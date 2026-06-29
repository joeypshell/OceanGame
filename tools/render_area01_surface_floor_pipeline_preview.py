from __future__ import annotations

import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_geometry_v1.json"
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_pipeline_preview_v1.png"
CROP_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_pipeline_camera_crop_v1.png"


def load_geometry() -> dict:
    return json.loads(GEOMETRY_PATH.read_text(encoding="utf-8"))


def bounds(geometry: dict) -> tuple[float, float, float, float]:
    points = []
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

    def transform(point: list[float]) -> tuple[int, int]:
        return (
            int((point[0] - min_x) * scale + offset_x),
            int((point[1] - min_y) * scale + offset_y),
        )

    return transform


def draw_preview(geometry: dict, size: tuple[int, int], crop_world: tuple[float, float, float, float] | None = None) -> Image.Image:
    world_bounds = bounds(geometry) if crop_world is None else crop_world
    tr = transform_factory(world_bounds, size)
    img = Image.new("RGBA", size, (5, 35, 59, 255))
    draw = ImageDraw.Draw(img, "RGBA")

    for y in range(size[1]):
        t = y / max(1, size[1] - 1)
        color = (
            int(35 * (1 - t) + 3 * t),
            int(150 * (1 - t) + 42 * t),
            int(184 * (1 - t) + 78 * t),
            255,
        )
        draw.line([(0, y), (size[0], y)], fill=color)

    surface_y = tr([0, 220])[1]
    draw.rectangle([0, 0, size[0], surface_y], fill=(76, 190, 218, 105))
    draw.line([(0, surface_y), (size[0], surface_y)], fill=(145, 240, 248, 165), width=4)

    for x, alpha, width in [(260, 26, 150), (780, 20, 210), (1280, 22, 180), (1780, 16, 220)]:
        draw.polygon(
            [(x - width // 2, 0), (x + width // 2, 0), (x - 120, size[1]), (x - 280, size[1])],
            fill=(88, 218, 240, alpha),
        )

    for region in geometry["regions"]:
        polygon = [tr(point) for point in region["approx_polygon"]]
        if region["kind"] == "open_surface":
            fill = (67, 220, 236, 18)
        elif region["kind"] == "locked_promise":
            fill = (80, 36, 92, 28)
        else:
            fill = (57, 172, 190, 28)
        draw.polygon(polygon, fill=fill)

    terrain_mask = Image.new("L", size, 0)
    mask_draw = ImageDraw.Draw(terrain_mask)
    for terrain in geometry["solid_terrain"]:
        mask_draw.polygon([tr(point) for point in terrain["polygon"]], fill=255)

    terrain_layer = Image.new("RGBA", size, (0, 0, 0, 0))
    terrain_draw = ImageDraw.Draw(terrain_layer, "RGBA")
    for terrain in geometry["solid_terrain"]:
        polygon = [tr(point) for point in terrain["polygon"]]
        terrain_draw.polygon(polygon, fill=(5, 25, 34, 248), outline=(30, 122, 135, 180))
        terrain_draw.line(polygon + [polygon[0]], fill=(75, 221, 226, 120), width=4)

    plates = Image.new("RGBA", size, (0, 0, 0, 0))
    plate_draw = ImageDraw.Draw(plates, "RGBA")
    for terrain in geometry["solid_terrain"]:
        polygon = [tr(point) for point in terrain["polygon"]]
        xs = [point[0] for point in polygon]
        ys = [point[1] for point in polygon]
        if len(xs) < 3:
            continue
        for index in range(max(3, min(28, (max(xs) - min(xs)) // 80))):
            x = min(xs) + (index * 83) % max(1, max(xs) - min(xs))
            y = min(ys) + (index * 47) % max(1, max(ys) - min(ys))
            plate_draw.rounded_rectangle([x, y, x + 74, y + 20], radius=10, fill=(20, 82, 94, 56))
    plates.putalpha(Image.composite(plates.getchannel("A"), Image.new("L", size, 0), terrain_mask))
    terrain_layer.alpha_composite(plates)
    img.alpha_composite(terrain_layer)

    edge = Image.composite(Image.new("L", size, 255), Image.new("L", size, 0), terrain_mask).filter(ImageFilter.FIND_EDGES)
    edge_layer = Image.new("RGBA", size, (84, 228, 230, 0))
    edge_layer.putalpha(edge.point(lambda p: min(90, p)))
    img.alpha_composite(edge_layer)

    for hook in geometry["scene_hooks"]:
        polygon = [tr(point) for point in hook["points"]]
        fill = (255, 210, 64, 55)
        outline = (255, 210, 64, 160)
        if hook["status"] == "future_locked" or hook["type"] == "gate":
            fill = (255, 80, 90, 58)
            outline = (255, 80, 90, 170)
        draw.polygon(polygon, fill=fill, outline=outline)

    for sprite in geometry["sprite_placements"]:
        x, y = tr(sprite["position"])
        family = sprite["asset_family"]
        if "ship" in family:
            draw.rounded_rectangle([x - 120, y - 40, x + 130, y], radius=8, fill=(18, 32, 36, 230), outline=(170, 230, 235, 150), width=2)
            draw.rectangle([x - 26, y, x + 26, y + 135], fill=(28, 145, 170, 90), outline=(140, 238, 248, 130), width=2)
        elif "gate" in family:
            draw.rounded_rectangle([x - 28, y - 72, x + 28, y + 72], radius=6, fill=(70, 42, 32, 200), outline=(255, 210, 72, 180), width=4)
        elif "vent" in family:
            draw.polygon([(x - 34, y + 42), (x + 34, y + 42), (x + 10, y - 56), (x - 10, y - 56)], fill=(232, 106, 36, 190), outline=(255, 170, 70, 150))
        else:
            draw.ellipse([x - 30, y - 18, x + 30, y + 18], fill=(84, 228, 230, 120), outline=(170, 250, 255, 140), width=2)

    return img


def main() -> None:
    geometry = load_geometry()
    full = draw_preview(geometry, (2400, 1200))
    full.save(OUTPUT_PATH)
    crop = draw_preview(geometry, (1536, 864), tuple(geometry["camera_bounds"]["first_review_crop"]))
    crop.save(CROP_PATH)
    print(OUTPUT_PATH)
    print(CROP_PATH)


if __name__ == "__main__":
    main()
