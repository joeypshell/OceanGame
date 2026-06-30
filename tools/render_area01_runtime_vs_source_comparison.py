from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
RUNTIME_MAP_PATH = ROOT / "docs/planning/maps/area_01_runtime_source_map_v3.json"
SOURCE_MAP_IMAGE_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_source_map_v1.png"
SCENE_PATH = ROOT / "scenes/Main.tscn"
OUT_DIR = ROOT / "docs/planning/maps"
CURRENT_OUT = OUT_DIR / "area_01_current_godot_runtime_map_2026_06_30.png"
SIDE_BY_SIDE_OUT = OUT_DIR / "area_01_runtime_vs_source_side_by_side_2026_06_30.png"
SUMMARY_OUT = OUT_DIR / "area_01_runtime_vs_source_side_by_side_2026_06_30.json"
POSITION_KEYS = {"position", "move_start", "move_end", "patrol_start", "patrol_end"}
STRING_KEYS = {"spawn_id", "category", "target_id", "route_id", "discovery_id", "display_name"}
VALIDATED_SPAWN_ROOTS = ["StarterResourceCandidates", "CreatureRouteCandidates"]
VALIDATED_DIRECT_ROOTS = ["ResourcePickups", "Creatures", "Predators", "Discoveries"]


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def get_font(size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    for name in ["arial.ttf", "segoeui.ttf"]:
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            pass
    return ImageFont.load_default()


def iter_points(entries: list[dict[str, Any]], keys: list[str]) -> list[tuple[float, float]]:
    points: list[tuple[float, float]] = []
    for entry in entries:
        for key in keys:
            raw = entry.get(key)
            if not isinstance(raw, list):
                continue
            for point in raw:
                if isinstance(point, list) and len(point) >= 2:
                    points.append((float(point[0]), float(point[1])))
        if isinstance(entry.get("position"), list) and len(entry["position"]) >= 2:
            points.append((float(entry["position"][0]), float(entry["position"][1])))
    return points


def runtime_bounds(runtime_map: dict[str, Any]) -> tuple[float, float, float, float]:
    points: list[tuple[float, float]] = []
    points += iter_points(runtime_map.get("solid_terrain", []), ["polygon"])
    points += iter_points(runtime_map.get("cave_mouths", []), ["entrance_polygon"])
    points += iter_points(runtime_map.get("scene_hooks", []), ["points"])
    points += iter_points(runtime_map.get("sprite_placements", []), [])
    points += iter_points(runtime_map.get("regions", []), ["approx_polygon"])
    min_x = min(x for x, _ in points)
    max_x = max(x for x, _ in points)
    min_y = min(y for _, y in points)
    max_y = max(y for _, y in points)
    pad_x = (max_x - min_x) * 0.03
    pad_y = (max_y - min_y) * 0.04
    return min_x - pad_x, min_y - pad_y, max_x + pad_x, max_y + pad_y


def parse_vector2(value: str) -> tuple[float, float] | None:
    match = re.search(r"Vector2\(\s*(-?\d+(?:\.\d+)?),\s*(-?\d+(?:\.\d+)?)\s*\)", value)
    if not match:
        return None
    return float(match.group(1)), float(match.group(2))


def parse_scene_nodes(path: Path) -> list[dict[str, Any]]:
    nodes: list[dict[str, Any]] = []
    current: dict[str, Any] | None = None
    for line in path.read_text(encoding="utf-8").splitlines():
        node_match = re.match(r'^\[node name="([^"]+)"(?: type="([^"]+)")? parent="([^"]*)"', line)
        if node_match:
            parent = node_match.group(3)
            current = {
                "name": node_match.group(1),
                "type": node_match.group(2) or "",
                "parent": parent,
                "props": {},
            }
            current["path"] = f"{parent}/{current['name']}" if parent and parent != "." else current["name"]
            nodes.append(current)
            continue
        if current is None:
            continue
        prop_match = re.match(r"^([A-Za-z0-9_]+) = (.+)$", line)
        if not prop_match:
            continue
        key = prop_match.group(1)
        value = prop_match.group(2)
        props = current["props"]
        if key in POSITION_KEYS:
            point = parse_vector2(value)
            if point is not None:
                props[key] = point
        elif key in STRING_KEYS:
            string_match = re.match(r'^"([^"]*)"', value)
            if string_match:
                props[key] = string_match.group(1)
        elif key == "visible":
            props["visible"] = value.strip() != "false"
    return nodes


def parent_node(node: dict[str, Any], by_path: dict[str, dict[str, Any]]) -> dict[str, Any] | None:
    parent = node.get("parent")
    if not parent or parent == ".":
        return None
    return by_path.get(parent)


def node_hidden(node: dict[str, Any], by_path: dict[str, dict[str, Any]]) -> bool:
    cursor: dict[str, Any] | None = node
    seen: set[str] = set()
    while cursor is not None:
        path = str(cursor.get("path", ""))
        if path in seen:
            return True
        seen.add(path)
        if cursor.get("props", {}).get("visible") is False:
            return True
        cursor = parent_node(cursor, by_path)
    return False


def global_node_position(node: dict[str, Any], by_path: dict[str, dict[str, Any]]) -> tuple[float, float]:
    x = 0.0
    y = 0.0
    cursor: dict[str, Any] | None = node
    seen: set[str] = set()
    while cursor is not None:
        path = str(cursor.get("path", ""))
        if path in seen:
            break
        seen.add(path)
        position = cursor.get("props", {}).get("position")
        if position:
            x += float(position[0])
            y += float(position[1])
        cursor = parent_node(cursor, by_path)
    return x, y


def has_validated_spawn_root(node: dict[str, Any]) -> bool:
    path = str(node.get("path", ""))
    return any(path == root or path.startswith(f"{root}/") for root in VALIDATED_SPAWN_ROOTS)


def direct_root(node: dict[str, Any]) -> str:
    parent = str(node.get("parent", ""))
    for root in VALIDATED_DIRECT_ROOTS:
        if parent == root:
            return root
    return ""


def collect_scene_targets(path: Path) -> list[dict[str, Any]]:
    nodes = parse_scene_nodes(path)
    by_path = {str(node["path"]): node for node in nodes}
    targets: list[dict[str, Any]] = []
    for node in nodes:
        if node_hidden(node, by_path):
            continue
        props = node.get("props", {})
        if props.get("spawn_id") and has_validated_spawn_root(node):
            targets.append(
                {
                    "kind": "spawn",
                    "id": ":".join([props.get("category", "resource"), props.get("target_id", node["name"]), props["spawn_id"]]),
                    "path": node["path"],
                    "point": global_node_position(node, by_path),
                }
            )
            continue
        root = direct_root(node)
        if not root or "position" not in props:
            continue
        kind = {
            "ResourcePickups": "pickup",
            "Creatures": "creature",
            "Predators": "predator",
            "Discoveries": "scan",
        }.get(root, "target")
        target_id = props.get("discovery_id") or props.get("display_name") or node["name"]
        targets.append(
            {
                "kind": kind,
                "id": target_id,
                "path": node["path"],
                "point": global_node_position(node, by_path),
            }
        )
        for endpoint_key in ["move_start", "move_end", "patrol_start", "patrol_end"]:
            endpoint = props.get(endpoint_key)
            if not endpoint or endpoint == (0.0, 0.0):
                continue
            targets.append(
                {
                    "kind": f"{kind}_path",
                    "id": f"{target_id}:{endpoint_key}",
                    "path": node["path"],
                    "point": endpoint,
                }
            )
    return targets


class RuntimeRenderer:
    def __init__(self, bounds: tuple[float, float, float, float], size: tuple[int, int]) -> None:
        self.min_x, self.min_y, self.max_x, self.max_y = bounds
        self.width, self.height = size
        self.margin_left = 34
        self.margin_top = 56
        self.margin_right = 24
        self.margin_bottom = 34
        content_w = self.width - self.margin_left - self.margin_right
        content_h = self.height - self.margin_top - self.margin_bottom
        self.scale = min(content_w / (self.max_x - self.min_x), content_h / (self.max_y - self.min_y))
        drawn_w = (self.max_x - self.min_x) * self.scale
        drawn_h = (self.max_y - self.min_y) * self.scale
        self.offset_x = self.margin_left + (content_w - drawn_w) * 0.5
        self.offset_y = self.margin_top + (content_h - drawn_h) * 0.5

    def point(self, raw: list[float] | tuple[float, float]) -> tuple[int, int]:
        x, y = float(raw[0]), float(raw[1])
        return (
            int(round(self.offset_x + (x - self.min_x) * self.scale)),
            int(round(self.offset_y + (y - self.min_y) * self.scale)),
        )

    def polygon(self, raw: list[list[float]]) -> list[tuple[int, int]]:
        return [self.point(point) for point in raw]


def centroid(points: list[list[float]]) -> tuple[float, float]:
    return (
        sum(float(point[0]) for point in points) / max(1, len(points)),
        sum(float(point[1]) for point in points) / max(1, len(points)),
    )


def render_runtime_map(
    runtime_map: dict[str, Any],
    size: tuple[int, int],
    with_labels: bool,
    scene_targets: list[dict[str, Any]],
) -> Image.Image:
    bounds = runtime_bounds(runtime_map)
    renderer = RuntimeRenderer(bounds, size)
    image = Image.new("RGB", size, "#dff4ff")
    draw = ImageDraw.Draw(image, "RGBA")
    title_font = get_font(24)
    label_font = get_font(12)
    small_font = get_font(10)

    draw.rectangle([0, 0, size[0], 42], fill=(18, 48, 68, 255))
    draw.text((18, 9), "Current Godot Runtime Map: area_01_runtime_source_map_v3", fill=(240, 250, 255, 255), font=title_font)
    draw.text((18, size[1] - 27), "Blue/white negative space is navigable water unless covered by gray source-map terrain.", fill=(20, 34, 42, 230), font=small_font)

    # Surface band.
    draw.rectangle([0, 43, size[0], renderer.point((0, 520))[1]], fill=(187, 230, 255, 128))

    for region in runtime_map.get("regions", []):
        poly = region.get("approx_polygon")
        if isinstance(poly, list):
            draw.line(renderer.polygon(poly) + [renderer.polygon(poly)[0]], fill=(76, 150, 190, 70), width=2)

    terrain_domain = runtime_map.get("terrain_domain", {})
    if isinstance(terrain_domain, dict) and isinstance(terrain_domain.get("polygon"), list):
        drawn = renderer.polygon(terrain_domain["polygon"])
        draw.polygon(drawn, fill=(142, 144, 145, 235), outline=(18, 18, 18, 255))
        draw.line(drawn + [drawn[0]], fill=(0, 0, 0, 255), width=4)

    for water in runtime_map.get("playable_water_regions", []):
        poly = water.get("polygon", [])
        if not isinstance(poly, list) or not poly:
            continue
        drawn = renderer.polygon(poly)
        if water.get("kind") == "open_surface":
            fill = (187, 230, 255, 80)
            outline = (42, 136, 190, 160)
            width = 2
        else:
            fill = (246, 252, 255, 248)
            outline = (0, 0, 0, 255)
            width = 4
        draw.polygon(drawn, fill=fill, outline=outline)
        draw.line(drawn + [drawn[0]], fill=outline, width=width)
        if with_labels and water.get("carves_collision"):
            cx, cy = centroid(poly)
            px, py = renderer.point((cx, cy))
            label = water.get("id", "")
            bbox = draw.textbbox((px, py), label, font=small_font)
            draw.rectangle([bbox[0] - 3, bbox[1] - 2, bbox[2] + 3, bbox[3] + 2], fill=(245, 245, 245, 190))
            draw.text((px, py), label, fill=(20, 20, 20, 255), font=small_font)

    for terrain in runtime_map.get("solid_terrain", []):
        if terrain.get("runtime_generation", {}).get("visual_role") != "collision_partition":
            continue
        poly = terrain.get("polygon", [])
        if not poly:
            continue
        drawn = renderer.polygon(poly)
        draw.line(drawn + [drawn[0]], fill=(220, 60, 40, 45), width=1)

    hook_colors = {
        "oxygen": (71, 208, 240, 95),
        "offload": (245, 203, 73, 120),
        "cave_entrance": (255, 255, 255, 0),
        "hazard": (224, 42, 42, 150),
        "return_current": (139, 82, 255, 140),
        "gate": (235, 42, 42, 160),
        "pickup": (26, 174, 114, 150),
        "scan": (44, 134, 230, 150),
    }
    for hook in runtime_map.get("scene_hooks", []):
        points = hook.get("points", [])
        if not points:
            continue
        color = hook_colors.get(hook.get("type", ""), (255, 255, 255, 110))
        drawn = renderer.polygon(points)
        draw.polygon(drawn, fill=color, outline=(0, 0, 0, 160))
        draw.line(drawn + [drawn[0]], fill=(0, 0, 0, 180), width=2)

    for sprite in runtime_map.get("sprite_placements", []):
        position = sprite.get("position")
        if not isinstance(position, list):
            continue
        x, y = renderer.point(position)
        family = str(sprite.get("asset_family", ""))
        if "gate" in family:
            fill = (240, 50, 45, 235)
            outline = (40, 20, 20, 255)
            draw.rectangle([x - 8, y - 22, x + 8, y + 22], fill=fill, outline=outline, width=2)
        elif "ship" in family:
            draw.rectangle([x - 36, y - 12, x + 36, y + 10], fill=(230, 230, 230, 255), outline=(0, 0, 0, 255), width=2)
        else:
            draw.ellipse([x - 7, y - 7, x + 7, y + 7], fill=(245, 210, 45, 235), outline=(0, 0, 0, 200), width=1)

    target_styles = {
        "spawn": ((8, 166, 103, 230), "circle"),
        "pickup": ((246, 199, 45, 240), "circle"),
        "creature": ((238, 109, 38, 230), "triangle"),
        "creature_path": ((238, 109, 38, 100), "small"),
        "predator": ((214, 44, 42, 235), "diamond"),
        "predator_path": ((214, 44, 42, 105), "small"),
        "scan": ((41, 133, 222, 230), "square"),
        "scan_path": ((41, 133, 222, 105), "small"),
    }
    for target in scene_targets:
        x, y = renderer.point(target["point"])
        fill, shape = target_styles.get(target["kind"], ((255, 255, 255, 220), "circle"))
        outline = (0, 0, 0, 190)
        if shape == "triangle":
            draw.polygon([(x, y - 7), (x - 7, y + 6), (x + 7, y + 6)], fill=fill, outline=outline)
        elif shape == "diamond":
            draw.polygon([(x, y - 8), (x + 8, y), (x, y + 8), (x - 8, y)], fill=fill, outline=outline)
        elif shape == "square":
            draw.rectangle([x - 6, y - 6, x + 6, y + 6], fill=fill, outline=outline)
        elif shape == "small":
            draw.ellipse([x - 3, y - 3, x + 3, y + 3], fill=fill, outline=None)
        else:
            draw.ellipse([x - 5, y - 5, x + 5, y + 5], fill=fill, outline=outline)

    legend_x = size[0] - 330
    legend_y = 54
    draw.rectangle([legend_x, legend_y, size[0] - 16, legend_y + 118], fill=(255, 255, 255, 225), outline=(0, 0, 0, 180), width=1)
    legend = [
        ("gray/black", "continuous generated terrain domain"),
        ("cyan", "oxygen surface / carved water"),
        ("red", "gates or hazards"),
        ("green/blue", "hooks + live placements"),
        ("purple", "return current hooks"),
    ]
    for idx, (sample, text) in enumerate(legend):
        y = legend_y + 12 + idx * 20
        color = {
            "gray/black": (142, 144, 145, 235),
            "cyan": (71, 208, 240, 120),
            "red": (235, 42, 42, 160),
            "green/blue": (26, 174, 114, 150),
            "purple": (139, 82, 255, 140),
        }[sample]
        draw.rectangle([legend_x + 10, y + 2, legend_x + 26, y + 15], fill=color, outline=(0, 0, 0, 180))
        draw.text((legend_x + 34, y), text, fill=(12, 24, 28, 255), font=label_font)

    return image


def add_title_panel(image: Image.Image, title: str, width: int, height: int) -> Image.Image:
    out = Image.new("RGB", (width, height), "#f4f6f7")
    resized = image.copy()
    resized.thumbnail((width - 24, height - 58), Image.Resampling.LANCZOS)
    x = (width - resized.width) // 2
    y = 48 + (height - 58 - resized.height) // 2
    out.paste(resized, (x, y))
    draw = ImageDraw.Draw(out)
    font = get_font(24)
    draw.rectangle([0, 0, width, 42], fill="#123044")
    draw.text((16, 8), title, fill="#f0faff", font=font)
    return out


def main() -> None:
    runtime_map = load_json(RUNTIME_MAP_PATH)
    source_image = Image.open(SOURCE_MAP_IMAGE_PATH).convert("RGB")
    scene_targets = collect_scene_targets(SCENE_PATH)

    current_full = render_runtime_map(runtime_map, (1800, 900), with_labels=True, scene_targets=scene_targets)
    current_full.save(CURRENT_OUT)

    current_panel = render_runtime_map(runtime_map, (1500, 820), with_labels=False, scene_targets=scene_targets)
    source_panel = add_title_panel(source_image, "Source Of Truth Map PNG", 1230, 820)

    gutter = 22
    side_by_side = Image.new("RGB", (current_panel.width + source_panel.width + gutter, 820), "#22272b")
    side_by_side.paste(current_panel, (0, 0))
    side_by_side.paste(source_panel, (current_panel.width + gutter, 0))
    side_by_side.save(SIDE_BY_SIDE_OUT)

    summary = {
        "runtime_map": str(RUNTIME_MAP_PATH.relative_to(ROOT)).replace("\\", "/"),
        "source_map_image": str(SOURCE_MAP_IMAGE_PATH.relative_to(ROOT)).replace("\\", "/"),
        "current_runtime_render": str(CURRENT_OUT.relative_to(ROOT)).replace("\\", "/"),
        "side_by_side_render": str(SIDE_BY_SIDE_OUT.relative_to(ROOT)).replace("\\", "/"),
        "runtime_canvas": runtime_map.get("coordinate_space", {}).get("stage_canvas"),
        "runtime_render_bounds": runtime_bounds(runtime_map),
        "source_image_size": list(source_image.size),
        "counts": {
            "solid_terrain": len(runtime_map.get("solid_terrain", [])),
            "playable_water_regions": len(runtime_map.get("playable_water_regions", [])),
            "cave_mouths": len(runtime_map.get("cave_mouths", [])),
            "scene_hooks": len(runtime_map.get("scene_hooks", [])),
            "sprite_placements": len(runtime_map.get("sprite_placements", [])),
            "scene_targets": len(scene_targets),
        },
        "generation_model": runtime_map.get("generation_model", {}),
    }
    SUMMARY_OUT.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(SIDE_BY_SIDE_OUT)
    print(CURRENT_OUT)
    print(SUMMARY_OUT)


if __name__ == "__main__":
    main()
