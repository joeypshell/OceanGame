from __future__ import annotations

import json
import math
from collections import defaultdict, deque
from pathlib import Path
from typing import Any

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE_IMAGE_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_source_map_v1.png"
GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_geometry_v1.json"
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_playable_water_trace_v1.json"

WHITE_THRESHOLD = 244
MIN_COMPONENT_AREA = 1200
MIN_COMPONENT_WIDTH = 30
MIN_COMPONENT_HEIGHT = 30
CONTOUR_SIMPLIFY_EPSILON = 6.0

WORLD_X_MIN = -900.0
WORLD_X_MAX = 4660.0
WORLD_TERRAIN_TOP_Y = 500.0
WORLD_TERRAIN_BOTTOM_Y = 2440.0
IMAGE_TERRAIN_TOP_Y = 145.0
IMAGE_TERRAIN_BOTTOM_Y = 990.0


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def should_sample_pixel(rgb: tuple[int, int, int], x: int, y: int) -> bool:
    red, green, blue = rgb
    is_white = red > WHITE_THRESHOLD and green > WHITE_THRESHOLD and blue > WHITE_THRESHOLD
    if y < 120:
        return False
    if x < 260 and y > 560:
        return False
    return is_white


def component_bounds(points: set[tuple[int, int]]) -> tuple[int, int, int, int]:
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    return min(xs), min(ys), max(xs), max(ys)


def find_components(image: Image.Image) -> list[dict[str, Any]]:
    width, height = image.size
    pixels = image.convert("RGB").load()
    mask = bytearray(width * height)
    for y in range(height):
        for x in range(width):
            if should_sample_pixel(pixels[x, y], x, y):
                mask[y * width + x] = 1

    seen = bytearray(width * height)
    components: list[dict[str, Any]] = []
    for y in range(height):
        for x in range(width):
            index = y * width + x
            if not mask[index] or seen[index]:
                continue

            queue: deque[tuple[int, int]] = deque([(x, y)])
            seen[index] = 1
            points: set[tuple[int, int]] = set()
            while queue:
                current_x, current_y = queue.popleft()
                points.add((current_x, current_y))
                for next_x, next_y in (
                    (current_x + 1, current_y),
                    (current_x - 1, current_y),
                    (current_x, current_y + 1),
                    (current_x, current_y - 1),
                ):
                    if 0 <= next_x < width and 0 <= next_y < height:
                        next_index = next_y * width + next_x
                        if mask[next_index] and not seen[next_index]:
                            seen[next_index] = 1
                            queue.append((next_x, next_y))

            min_x, min_y, max_x, max_y = component_bounds(points)
            if (
                len(points) >= MIN_COMPONENT_AREA
                and max_x - min_x >= MIN_COMPONENT_WIDTH
                and max_y - min_y >= MIN_COMPONENT_HEIGHT
            ):
                components.append(
                    {
                        "points": points,
                        "area_pixels": len(points),
                        "image_bounds": [min_x, min_y, max_x, max_y],
                    }
                )

    components.sort(key=lambda entry: (entry["image_bounds"][1], entry["image_bounds"][0]))
    return components


def directed_boundary_loops(points: set[tuple[int, int]]) -> list[list[tuple[int, int]]]:
    starts: dict[tuple[int, int], list[tuple[int, int]]] = defaultdict(list)
    for x, y in points:
        if (x, y - 1) not in points:
            starts[(x, y)].append((x + 1, y))
        if (x + 1, y) not in points:
            starts[(x + 1, y)].append((x + 1, y + 1))
        if (x, y + 1) not in points:
            starts[(x + 1, y + 1)].append((x, y + 1))
        if (x - 1, y) not in points:
            starts[(x, y + 1)].append((x, y))

    loops: list[list[tuple[int, int]]] = []
    while starts:
        start = next(iter(starts))
        current = start
        loop = [start]
        for _ in range(250_000):
            outgoing = starts.get(current)
            if not outgoing:
                break
            next_point = outgoing.pop()
            if not outgoing:
                del starts[current]
            loop.append(next_point)
            current = next_point
            if current == start:
                break
        if len(loop) > 4 and loop[-1] == start:
            loops.append(loop)
    return loops


def polygon_area(points: list[tuple[float, float]]) -> float:
    total = 0.0
    for index, point in enumerate(points):
        next_point = points[(index + 1) % len(points)]
        total += point[0] * next_point[1] - next_point[0] * point[1]
    return total * 0.5


def perpendicular_distance(
    point: tuple[float, float],
    start: tuple[float, float],
    end: tuple[float, float],
) -> float:
    start_x, start_y = start
    end_x, end_y = end
    point_x, point_y = point
    delta_x = end_x - start_x
    delta_y = end_y - start_y
    if delta_x == 0 and delta_y == 0:
        return math.hypot(point_x - start_x, point_y - start_y)
    return abs(delta_y * point_x - delta_x * point_y + end_x * start_y - end_y * start_x) / math.hypot(delta_x, delta_y)


def simplify_polygon(points: list[tuple[int, int]], epsilon: float) -> list[tuple[int, int]]:
    if len(points) < 3:
        return points
    start = points[0]
    end = points[-1]
    max_distance = -1.0
    split_index = 0
    for index in range(1, len(points) - 1):
        distance = perpendicular_distance(points[index], start, end)
        if distance > max_distance:
            max_distance = distance
            split_index = index
    if max_distance > epsilon:
        return simplify_polygon(points[: split_index + 1], epsilon)[:-1] + simplify_polygon(points[split_index:], epsilon)
    return [start, end]


def world_point(image_point: tuple[int, int], image_size: tuple[int, int]) -> list[float]:
    image_x, image_y = image_point
    image_width, _ = image_size
    world_x = WORLD_X_MIN + (image_x / image_width) * (WORLD_X_MAX - WORLD_X_MIN)
    world_y = WORLD_TERRAIN_TOP_Y + ((image_y - IMAGE_TERRAIN_TOP_Y) / (IMAGE_TERRAIN_BOTTOM_Y - IMAGE_TERRAIN_TOP_Y)) * (
        WORLD_TERRAIN_BOTTOM_Y - WORLD_TERRAIN_TOP_Y
    )
    return [round(world_x, 3), round(world_y, 3)]


def classify_component(component: dict[str, Any]) -> dict[str, Any]:
    min_x, min_y, max_x, max_y = component["image_bounds"]
    if max_x < 360 and max_y < 390:
        return {
            "id": "source_trace_starter_kelp_pocket",
            "display_name": "Traced Starter Kelp Pocket",
            "source_region_ids": ["starter_kelp_cave"],
            "status": "planned",
        }
    if min_x > 1120 and max_y < 520:
        return {
            "id": "source_trace_pressure_wreck_branch",
            "display_name": "Traced Pressure Wreck Branch",
            "source_region_ids": ["pressure_wreck_branch"],
            "status": "planned",
        }
    if min_x > 1350 and min_y > 820:
        return {
            "id": "source_trace_future_exit_room",
            "display_name": "Traced Future Exit Room",
            "source_region_ids": ["future_deep_exit"],
            "status": "future_locked",
        }
    if min_y > 640:
        return {
            "id": "source_trace_blue_chimney_deep_route",
            "display_name": "Traced Blue Chimney Deep Route",
            "source_region_ids": ["blue_chimney_route", "future_deep_exit"],
            "status": "planned",
        }
    if min_x > 520 and max_x > 1000:
        return {
            "id": "source_trace_thermal_vent_corridor",
            "display_name": "Traced Thermal Vent Corridor",
            "source_region_ids": ["thermal_vent_pocket", "shell_reef_bank_cave"],
            "status": "planned",
        }
    return {
        "id": "source_trace_shell_reef_bank",
        "display_name": "Traced Shell Reef Bank",
        "source_region_ids": ["shell_reef_bank_cave", "blue_chimney_route"],
        "status": "planned",
    }


def main() -> None:
    image = Image.open(SOURCE_IMAGE_PATH)
    geometry = load_json(GEOMETRY_PATH)
    known_regions = {str(region["id"]) for region in geometry.get("regions", [])}
    components = find_components(image)
    playable_regions: list[dict[str, Any]] = []

    for component in components:
        loops = directed_boundary_loops(component["points"])
        if not loops:
            continue
        loops.sort(key=lambda loop: abs(polygon_area(loop)), reverse=True)
        simplified = simplify_polygon(loops[0], CONTOUR_SIMPLIFY_EPSILON)
        if simplified[-1] == simplified[0]:
            simplified = simplified[:-1]
        if polygon_area(simplified) < 0:
            simplified.reverse()

        classification = classify_component(component)
        unknown_refs = [region_id for region_id in classification["source_region_ids"] if region_id not in known_regions]
        if unknown_refs:
            raise RuntimeError(f"{classification['id']} references unknown regions: {unknown_refs}")

        playable_regions.append(
            {
                "id": classification["id"],
                "display_name": classification["display_name"],
                "kind": "source_png_trace",
                "role": "Playable cave/corridor water traced from the accepted Area 01 source-map PNG.",
                "source_region_ids": classification["source_region_ids"],
                "status": classification["status"],
                "polygon": [world_point(point, image.size) for point in simplified],
                "image_polygon": [[point[0], point[1]] for point in simplified],
                "image_bounds": component["image_bounds"],
                "area_pixels": component["area_pixels"],
                "carves_terrain_collision": True,
            }
        )

    output = {
        "schema_version": 1,
        "id": "area_01_playable_water_trace_v1",
        "status": "generated_source_png_playable_water_trace",
        "source_image": str(SOURCE_IMAGE_PATH.relative_to(ROOT)).replace("\\", "/"),
        "source_geometry": str(GEOMETRY_PATH.relative_to(ROOT)).replace("\\", "/"),
        "purpose": "Deterministic traced playable-water/cave-corridor topology for Area 01 runtime generation.",
        "extraction_policy": {
            "white_threshold_rgb_gt": WHITE_THRESHOLD,
            "excluded_top_rows_lt": 120,
            "excluded_legend_region": {"x_lt": 260, "y_gt": 560},
            "min_component_area": MIN_COMPONENT_AREA,
            "min_component_width": MIN_COMPONENT_WIDTH,
            "min_component_height": MIN_COMPONENT_HEIGHT,
            "contour_simplify_epsilon_px": CONTOUR_SIMPLIFY_EPSILON,
        },
        "world_mapping": {
            "world_x_min": WORLD_X_MIN,
            "world_x_max": WORLD_X_MAX,
            "world_terrain_top_y": WORLD_TERRAIN_TOP_Y,
            "world_terrain_bottom_y": WORLD_TERRAIN_BOTTOM_Y,
            "image_terrain_top_y": IMAGE_TERRAIN_TOP_Y,
            "image_terrain_bottom_y": IMAGE_TERRAIN_BOTTOM_Y,
            "image_size": [image.size[0], image.size[1]],
        },
        "playable_water_regions": playable_regions,
    }

    OUTPUT_PATH.write_text(json.dumps(output, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(OUTPUT_PATH)
    print(f"traced {len(playable_regions)} playable water regions")


if __name__ == "__main__":
    main()
