from __future__ import annotations

import json
import math
import random
from pathlib import Path
from typing import Any

from PIL import Image, ImageChops, ImageDraw, ImageFilter, ImageOps


ROOT = Path(__file__).resolve().parents[1]
GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_runtime_source_map_v3.json"
KIT_MANIFEST_PATH = ROOT / "docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json"
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_sprite_kit_v4_preview_v1.png"
CROP_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_sprite_kit_v4_camera_crop_v1.png"
CLEAN_OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_sprite_kit_v4_clean_preview_v1.png"
CLEAN_CROP_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_sprite_kit_v4_clean_camera_crop_v1.png"
METADATA_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_sprite_kit_v4_preview_v1.json"


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def bounds(geometry: dict[str, Any]) -> tuple[float, float, float, float]:
    points: list[list[float]] = []
    for entry in geometry["solid_terrain"]:
        points.extend(entry["polygon"])
    for entry in geometry["regions"]:
        points.extend(entry["approx_polygon"])
    min_x = min(point[0] for point in points) - 180
    min_y = min(point[1] for point in points) - 80
    max_x = max(point[0] for point in points) + 180
    max_y = max(point[1] for point in points) + 100
    return min_x, min_y, max_x, max_y


def transform_factory(world_bounds: tuple[float, float, float, float], size: tuple[int, int]):
    min_x, min_y, max_x, max_y = world_bounds
    scale = min(size[0] / (max_x - min_x), size[1] / (max_y - min_y))
    offset_x = (size[0] - (max_x - min_x) * scale) * 0.5
    offset_y = (size[1] - (max_y - min_y) * scale) * 0.5

    def transform(point: list[float] | tuple[float, float]) -> tuple[int, int]:
        return (
            int((point[0] - min_x) * scale + offset_x),
            int((point[1] - min_y) * scale + offset_y),
        )

    return transform, scale


def alpha_trim(img: Image.Image, pad: int = 0) -> Image.Image:
    rgba = img.convert("RGBA")
    bbox = rgba.getchannel("A").getbbox()
    if bbox is None:
        return rgba
    left = max(0, bbox[0] - pad)
    top = max(0, bbox[1] - pad)
    right = min(rgba.width, bbox[2] + pad)
    bottom = min(rgba.height, bbox[3] + pad)
    return rgba.crop((left, top, right, bottom))


def load_kit(manifest: dict[str, Any]) -> dict[str, Image.Image]:
    sprites: dict[str, Image.Image] = {}
    for cell in manifest["cells"]:
        sprites[cell["id"]] = alpha_trim(Image.open(ROOT / cell["frame"]), pad=2)
    return sprites


def resize_by_width(img: Image.Image, width: int) -> Image.Image:
    width = max(8, int(width))
    scale = width / img.width
    height = max(8, int(img.height * scale))
    return img.resize((width, height), Image.Resampling.LANCZOS)


def resize_by_height(img: Image.Image, height: int) -> Image.Image:
    height = max(8, int(height))
    scale = height / img.height
    width = max(8, int(img.width * scale))
    return img.resize((width, height), Image.Resampling.LANCZOS)


def fade_sprite(img: Image.Image, alpha_scale: float) -> Image.Image:
    faded = img.copy()
    alpha = faded.getchannel("A").point(lambda p: int(p * alpha_scale))
    faded.putalpha(alpha)
    return faded


def center_crop_alpha(img: Image.Image, width_ratio: float, height_ratio: float) -> Image.Image:
    trimmed = alpha_trim(img)
    width = max(8, int(trimmed.width * width_ratio))
    height = max(8, int(trimmed.height * height_ratio))
    left = max(0, (trimmed.width - width) // 2)
    top = max(0, (trimmed.height - height) // 2)
    return trimmed.crop((left, top, left + width, top + height))


def paste_center(layer: Image.Image, sprite: Image.Image, x: int, y: int) -> None:
    layer.alpha_composite(sprite, (int(x - sprite.width * 0.5), int(y - sprite.height * 0.5)))


def polygon_mask(size: tuple[int, int], points: list[tuple[int, int]]) -> Image.Image:
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).polygon(points, fill=255)
    return mask


def clipped_alpha_composite(base: Image.Image, layer: Image.Image, mask: Image.Image) -> None:
    masked = Image.new("RGBA", base.size, (0, 0, 0, 0))
    alpha = ImageChops.multiply(layer.getchannel("A"), mask)
    masked.paste(layer, (0, 0))
    masked.putalpha(alpha)
    base.alpha_composite(masked)


def tile_fill(
    size: tuple[int, int],
    mask: Image.Image,
    bbox: tuple[int, int, int, int],
    sprite: Image.Image,
    tile_width: int,
    alpha_scale: float,
) -> Image.Image:
    layer = Image.new("RGBA", size, (0, 0, 0, 0))
    tile = resize_by_width(center_crop_alpha(sprite, 0.54, 0.54), tile_width)
    tile = fade_sprite(tile, alpha_scale)
    left, top, right, bottom = bbox
    step_x = max(54, int(tile.width * 0.92))
    step_y = max(46, int(tile.height * 0.84))
    rng = random.Random((left * 31) + (top * 17) + (right * 13) + (bottom * 7))
    row = 0
    for y in range(top - tile.height, bottom + tile.height, step_y):
        x_offset = (-step_x // 2 if row % 2 else 0) + rng.randint(-18, 18)
        for x in range(left - tile.width + x_offset, right + tile.width, step_x):
            jitter_y = rng.randint(-12, 12)
            variant = tile
            if rng.randint(0, 1) == 1:
                variant = ImageOps.mirror(variant)
            if rng.randint(0, 4) == 1:
                variant = ImageOps.flip(variant)
            layer.alpha_composite(variant, (x, y + jitter_y))
        row += 1
    clipped = Image.new("RGBA", size, (0, 0, 0, 0))
    alpha = ImageChops.multiply(layer.getchannel("A"), mask)
    clipped.paste(layer, (0, 0))
    clipped.putalpha(alpha)
    return clipped


def draw_background(img: Image.Image, world_bounds: tuple[float, float, float, float], size: tuple[int, int]) -> None:
    draw = ImageDraw.Draw(img, "RGBA")
    for y in range(size[1]):
        t = y / max(1, size[1] - 1)
        color = (
            int(18 * (1 - t) + 2 * t),
            int(116 * (1 - t) + 32 * t),
            int(156 * (1 - t) + 68 * t),
            255,
        )
        draw.line([(0, y), (size[0], y)], fill=color)

    tr, _ = transform_factory(world_bounds, size)
    surface_y = tr([0, 220])[1]
    draw.rectangle([0, 0, size[0], surface_y], fill=(86, 215, 234, 55))
    draw.line([(0, surface_y), (size[0], surface_y)], fill=(166, 250, 255, 116), width=3)

    for x, alpha, width in [(250, 20, 180), (760, 16, 245), (1250, 14, 190), (1770, 13, 240), (2150, 12, 220)]:
        draw.polygon(
            [(x - width // 2, 0), (x + width // 2, 0), (x - 95, size[1]), (x - 310, size[1])],
            fill=(99, 224, 246, alpha),
        )


def classify_edge(a: list[float], b: list[float]) -> str:
    dx = b[0] - a[0]
    dy = b[1] - a[1]
    angle = abs(math.degrees(math.atan2(dy, dx)))
    if angle > 90:
        angle = 180 - angle
    if angle <= 18:
        return "horizontal"
    if angle >= 68:
        return "vertical"
    return "diagonal"


def tile_edge(
    layer: Image.Image,
    sprite: Image.Image,
    start: tuple[int, int],
    end: tuple[int, int],
    target_width: int,
    rotate_to_edge: bool = True,
) -> int:
    dx = end[0] - start[0]
    dy = end[1] - start[1]
    length = math.hypot(dx, dy)
    if length < max(54, target_width * 0.8):
        return 0
    count = max(1, int(length // max(54, target_width * 1.35)))
    angle = math.degrees(math.atan2(dy, dx))
    base = resize_by_width(sprite, target_width)
    if rotate_to_edge:
        base = base.rotate(angle, resample=Image.Resampling.BICUBIC, expand=True)
    for index in range(count + 1):
        t = index / max(1, count)
        x = int(start[0] + dx * t)
        y = int(start[1] + dy * t)
        paste_center(layer, base, x, y)
    return count + 1


def tile_vertical_edge(layer: Image.Image, sprite: Image.Image, start: tuple[int, int], end: tuple[int, int], target_height: int) -> int:
    dx = end[0] - start[0]
    dy = end[1] - start[1]
    length = math.hypot(dx, dy)
    if length < max(54, target_height * 0.8):
        return 0
    base = resize_by_height(sprite, target_height)
    count = max(1, int(length // max(54, base.height * 1.35)))
    for index in range(count + 1):
        t = index / max(1, count)
        x = int(start[0] + dx * t)
        y = int(start[1] + dy * t)
        paste_center(layer, base, x, y)
    return count + 1


def draw_terrain_with_kit(
    img: Image.Image,
    geometry: dict[str, Any],
    sprites: dict[str, Image.Image],
    world_bounds: tuple[float, float, float, float],
    size: tuple[int, int],
) -> dict[str, Any]:
    tr, scale = transform_factory(world_bounds, size)
    draw = ImageDraw.Draw(img, "RGBA")
    placement_summary: list[dict[str, Any]] = []
    total_edge_sprites = 0

    for region in geometry["regions"]:
        polygon = [tr(point) for point in region["approx_polygon"]]
        if region["kind"] == "open_surface":
            fill = (80, 230, 245, 12)
        elif region["kind"] == "locked_promise":
            fill = (90, 42, 110, 22)
        else:
            fill = (78, 183, 201, 18)
        draw.polygon(polygon, fill=fill)

    terrain_layer = Image.new("RGBA", size, (0, 0, 0, 0))
    fill_sprite = sprites["reef_wall_fill_material"]
    lip_middle = sprites["seafloor_top_lip_middle_repeat"]
    ceiling_mid = sprites["cave_ceiling_underside_middle_repeat"]
    vertical_mid = sprites["vertical_wall_middle_repeat"]
    slope = sprites["diagonal_slope_edge_trim"]
    deep_lip = sprites["deep_floor_lip_strip"]
    thin_lip = sprites["thin_interior_ledge_strip"]

    for terrain in geometry["solid_terrain"]:
        polygon = [tr(point) for point in terrain["polygon"]]
        mask = polygon_mask(size, polygon)
        xs = [point[0] for point in polygon]
        ys = [point[1] for point in polygon]
        bbox = (min(xs), min(ys), max(xs), max(ys))

        base = Image.new("RGBA", size, (0, 0, 0, 0))
        ImageDraw.Draw(base, "RGBA").polygon(polygon, fill=(2, 18, 25, 252))
        clipped_alpha_composite(terrain_layer, base, mask)

        fill_width = max(64, int(172 * scale))
        texture = tile_fill(size, mask, bbox, fill_sprite, fill_width, 0.13)
        terrain_layer.alpha_composite(texture)

        edge_layer = Image.new("RGBA", size, (0, 0, 0, 0))
        edge_counts = {"horizontal": 0, "vertical": 0, "diagonal": 0}
        centroid_y = sum(point[1] for point in terrain["polygon"]) / len(terrain["polygon"])
        points = terrain["polygon"]
        pixel_points = polygon
        for index, start_world in enumerate(points):
            end_world = points[(index + 1) % len(points)]
            start = pixel_points[index]
            end = pixel_points[(index + 1) % len(pixel_points)]
            edge_kind = classify_edge(start_world, end_world)
            edge_mid_world_y = (start_world[1] + end_world[1]) * 0.5
            line_draw = ImageDraw.Draw(edge_layer, "RGBA")
            line_draw.line([start, end], fill=(4, 36, 45, 182), width=max(3, int(14 * scale)))
            line_draw.line([start, end], fill=(106, 234, 223, 52), width=max(1, int(3 * scale)))

            if edge_kind == "horizontal":
                if edge_mid_world_y <= centroid_y:
                    sprite = deep_lip if "deep" in terrain["id"] or "future" in terrain["id"] else lip_middle
                else:
                    sprite = ceiling_mid if "shelf" not in terrain["id"] else thin_lip
                added = tile_edge(edge_layer, fade_sprite(sprite, 0.36), start, end, max(72, int(176 * scale)), rotate_to_edge=True)
                edge_counts[edge_kind] += added
            elif edge_kind == "vertical":
                added = tile_vertical_edge(edge_layer, fade_sprite(vertical_mid, 0.27), start, end, max(84, int(190 * scale)))
                edge_counts[edge_kind] += added
            else:
                added = tile_edge(edge_layer, fade_sprite(slope, 0.26), start, end, max(72, int(160 * scale)), rotate_to_edge=True)
                edge_counts[edge_kind] += added

        terrain_layer.alpha_composite(edge_layer)
        total_edge_sprites += sum(edge_counts.values())
        placement_summary.append(
            {
                "terrain_id": terrain["id"],
                "fill_asset": "reef_wall_fill_material",
                "edge_counts": edge_counts,
                "preview_only": True,
            }
        )

    shadow = terrain_layer.filter(ImageFilter.GaussianBlur(3))
    shadow_alpha = shadow.getchannel("A").point(lambda p: int(p * 0.26))
    shadow.putalpha(shadow_alpha)
    img.alpha_composite(shadow)
    img.alpha_composite(terrain_layer)

    edge_mask = Image.new("L", size, 0)
    mask_draw = ImageDraw.Draw(edge_mask)
    for terrain in geometry["solid_terrain"]:
        mask_draw.polygon([tr(point) for point in terrain["polygon"]], fill=255)
    edge = edge_mask.filter(ImageFilter.FIND_EDGES)
    edge_layer = Image.new("RGBA", size, (90, 240, 238, 0))
    edge_layer.putalpha(edge.point(lambda p: min(52, p)))
    img.alpha_composite(edge_layer)

    return {
        "terrain_count": len(geometry["solid_terrain"]),
        "edge_sprite_instances": total_edge_sprites,
        "placements": placement_summary,
    }


def draw_hooks_and_objects(
    img: Image.Image,
    geometry: dict[str, Any],
    world_bounds: tuple[float, float, float, float],
    size: tuple[int, int],
) -> None:
    tr, scale = transform_factory(world_bounds, size)
    draw = ImageDraw.Draw(img, "RGBA")
    for hook in geometry["scene_hooks"]:
        polygon = [tr(point) for point in hook["points"]]
        fill = (255, 214, 74, 12)
        outline = (255, 214, 74, 70)
        if hook["status"] == "future_locked" or hook["type"] == "gate":
            fill = (255, 82, 98, 18)
            outline = (255, 82, 98, 90)
        elif hook["type"] in {"pickup", "scan"}:
            fill = (77, 232, 240, 16)
            outline = (126, 250, 255, 88)
        draw.polygon(polygon, fill=fill, outline=outline)

    for sprite in geometry["sprite_placements"]:
        x, y = tr(sprite["position"])
        family = sprite["asset_family"]
        if "ship" in family:
            ship_w = int(330 * scale)
            ship_h = int(65 * scale)
            draw.rounded_rectangle([x - ship_w // 2, y - ship_h, x + ship_w // 2, y], radius=8, fill=(13, 28, 34, 190), outline=(160, 234, 239, 105), width=2)
            draw.rectangle([x - int(34 * scale), y, x + int(34 * scale), y + int(150 * scale)], fill=(22, 145, 168, 50), outline=(152, 242, 250, 92), width=2)
        elif "gate" in family:
            gate_w = int(62 * scale)
            gate_h = int(172 * scale)
            draw.rounded_rectangle([x - gate_w // 2, y - gate_h // 2, x + gate_w // 2, y + gate_h // 2], radius=6, fill=(55, 30, 28, 160), outline=(255, 210, 88, 125), width=3)
        elif "vent" in family:
            draw.polygon([(x - int(48 * scale), y + int(54 * scale)), (x + int(48 * scale), y + int(54 * scale)), (x + int(15 * scale), y - int(70 * scale)), (x - int(15 * scale), y - int(70 * scale))], fill=(235, 102, 38, 190), outline=(255, 175, 80, 150))
        else:
            radius = max(8, int(32 * scale))
            draw.ellipse([x - radius, y - radius // 2, x + radius, y + radius // 2], fill=(86, 236, 235, 115), outline=(174, 252, 255, 135), width=2)


def draw_preview(
    geometry: dict[str, Any],
    kit_manifest: dict[str, Any],
    size: tuple[int, int],
    crop_world: tuple[float, float, float, float] | None = None,
    include_overlays: bool = True,
) -> tuple[Image.Image, dict[str, Any]]:
    world_bounds = bounds(geometry) if crop_world is None else crop_world
    img = Image.new("RGBA", size, (5, 35, 59, 255))
    draw_background(img, world_bounds, size)
    sprites = load_kit(kit_manifest)
    summary = draw_terrain_with_kit(img, geometry, sprites, world_bounds, size)
    if include_overlays:
        draw_hooks_and_objects(img, geometry, world_bounds, size)
    return img, summary


def main() -> None:
    geometry = load_json(GEOMETRY_PATH)
    kit_manifest = load_json(KIT_MANIFEST_PATH)
    full, full_summary = draw_preview(geometry, kit_manifest, (2400, 1200), include_overlays=True)
    full.save(OUTPUT_PATH)
    crop_world = tuple(geometry["camera_bounds"]["first_review_crop"])
    crop, crop_summary = draw_preview(geometry, kit_manifest, (1536, 864), crop_world, include_overlays=True)
    crop.save(CROP_PATH)
    clean_full, clean_full_summary = draw_preview(geometry, kit_manifest, (2400, 1200), include_overlays=False)
    clean_full.save(CLEAN_OUTPUT_PATH)
    clean_crop, clean_crop_summary = draw_preview(geometry, kit_manifest, (1536, 864), crop_world, include_overlays=False)
    clean_crop.save(CLEAN_CROP_PATH)
    metadata = {
        "schema_version": 1,
        "id": "area_01_surface_floor_sprite_kit_v3_preview_v1",
        "status": "runtime_v2_preview_from_active_source_map",
        "geometry_source": str(GEOMETRY_PATH.relative_to(ROOT)).replace("\\", "/"),
        "kit_manifest": str(KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
        "full_preview": str(OUTPUT_PATH.relative_to(ROOT)).replace("\\", "/"),
        "camera_crop_preview": str(CROP_PATH.relative_to(ROOT)).replace("\\", "/"),
        "clean_full_preview": str(CLEAN_OUTPUT_PATH.relative_to(ROOT)).replace("\\", "/"),
        "clean_camera_crop_preview": str(CLEAN_CROP_PATH.relative_to(ROOT)).replace("\\", "/"),
        "runtime_policy": {
            "wire_status": "wired through Area01BlockoutBuilder",
            "sprites_define_collision": False,
            "collision_source": "area_01_runtime_source_map_v3.json active geometry/collision authority; area_01_blockout_source_map_v1.json remains only as a fallback load path"
        },
        "render_policy": {
            "terrain_fill": "reef_wall_fill_material clipped to each source-map terrain polygon",
            "edge_trims": "kit ledge, vertical, diagonal, ceiling, thin ledge, and deep-floor sprites placed along polygon edges",
            "hooks": "scene hooks drawn as translucent planning overlays, not sprite-kit terrain",
            "objects": "ship, gates, vent, pickups, scans remain schematic because this pass only applies the structural terrain kit"
        },
        "full_summary": full_summary,
        "camera_crop_summary": crop_summary,
        "clean_full_summary": clean_full_summary,
        "clean_camera_crop_summary": clean_crop_summary
    }
    METADATA_PATH.write_text(json.dumps(metadata, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(OUTPUT_PATH)
    print(CROP_PATH)
    print(CLEAN_OUTPUT_PATH)
    print(CLEAN_CROP_PATH)
    print(METADATA_PATH)


if __name__ == "__main__":
    main()
