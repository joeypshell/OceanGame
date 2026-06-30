from __future__ import annotations

import copy
import json
import re
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
ACCEPTED_GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_geometry_v1.json"
CURRENT_BLOCKOUT_PATH = ROOT / "docs/planning/maps/area_01_blockout_source_map_v1.json"
COMPARISON_PATH = ROOT / "docs/planning/maps/area_01_map_truth_comparison_v1.json"
TERRAIN_KIT_MANIFEST_PATH = ROOT / "docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json"
SURFACE_SOURCE_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_source_map_v1.json"
SURFACE_OBJECTS_PATH = ROOT / "data/maps/area_01_surface_floor_objects_v1.json"
PLAYABLE_WATER_TRACE_PATH = ROOT / "docs/planning/maps/area_01_playable_water_trace_v1.json"
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_runtime_source_map_v3.json"
GRID_CELL_SIZE = 80
TERRAIN_DOMAIN = {
    "id": "continuous_undersea_terrain_domain",
    "role": "Continuous solid seafloor mass below the open surface. Playable cave water is carved out of this domain.",
    "polygon": [[-900, 500], [4660, 500], [4660, 2440], [-900, 2440]],
    "visual_strategy": "One Polygon2D terrain fill for the continuous undersea mass, with water cutout overlays for caves and mouths.",
    "collision_strategy": "Generated CollisionPolygon2D partitions from this domain minus playable_water_regions.",
    "rim_strategy": "Water-region edge Line2D cues; no per-partition visual seams.",
    "blocks_player": True,
}
CARVING_REGION_KINDS = {"cave", "pocket", "locked_promise"}

SEMANTIC_TRIM_SEGMENTS: dict[str, list[dict[str, Any]]] = {
    "surface_shelf_west": [
        {
            "id": "surface_shelf_west_top_lip",
            "type": "top_lip",
            "start": [-900, 510],
            "end": [-250, 510],
            "offset": [0, -10],
            "repeat_spacing": 210,
            "scale": 0.2,
            "alpha": 0.52,
        },
    ],
    "ship_shelf_left": [
        {
            "id": "ship_shelf_left_top_lip",
            "type": "top_lip",
            "start": [-250, 510],
            "end": [360, 516],
            "offset": [0, -10],
            "repeat_spacing": 210,
            "scale": 0.2,
            "alpha": 0.52,
        },
        {
            "id": "ship_shelf_left_underside",
            "type": "underside",
            "start": [-225, 676],
            "end": [245, 672],
            "offset": [0, 12],
            "repeat_spacing": 230,
            "scale": 0.18,
            "alpha": 0.34,
        },
    ],
    "ship_shelf_right": [
        {
            "id": "ship_shelf_right_top_lip",
            "type": "top_lip",
            "start": [760, 515],
            "end": [1550, 520],
            "offset": [0, -10],
            "repeat_spacing": 210,
            "scale": 0.2,
            "alpha": 0.55,
        },
        {
            "id": "ship_shelf_right_underside",
            "type": "underside",
            "start": [930, 718],
            "end": [1485, 714],
            "offset": [0, 12],
            "repeat_spacing": 230,
            "scale": 0.18,
            "alpha": 0.36,
        },
    ],
    "mid_seafloor_shelf": [
        {
            "id": "mid_seafloor_top_lip",
            "type": "top_lip",
            "start": [1750, 518],
            "end": [2800, 505],
            "offset": [0, -10],
            "repeat_spacing": 230,
            "scale": 0.2,
            "alpha": 0.52,
        },
        {
            "id": "mid_seafloor_underside",
            "type": "underside",
            "start": [1950, 760],
            "end": [2730, 770],
            "offset": [0, 12],
            "repeat_spacing": 250,
            "scale": 0.18,
            "alpha": 0.32,
        },
        {
            "id": "mid_seafloor_right_drop_slope",
            "type": "diagonal_slope",
            "start": [2800, 505],
            "end": [2845, 720],
            "offset": [12, 0],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.24,
        },
    ],
    "east_seafloor_shelf": [
        {
            "id": "east_seafloor_top_lip",
            "type": "top_lip",
            "start": [3040, 512],
            "end": [4600, 510],
            "offset": [0, -10],
            "repeat_spacing": 250,
            "scale": 0.2,
            "alpha": 0.5,
        },
        {
            "id": "east_seafloor_underside",
            "type": "underside",
            "start": [3220, 762],
            "end": [4410, 842],
            "offset": [0, 12],
            "repeat_spacing": 260,
            "scale": 0.18,
            "alpha": 0.3,
        },
        {
            "id": "east_seafloor_pressure_mouth_slope",
            "type": "diagonal_slope",
            "start": [3040, 710],
            "end": [3220, 762],
            "offset": [-8, 8],
            "repeat_spacing": 210,
            "scale": 0.15,
            "alpha": 0.24,
        },
    ],
    "starter_kelp_left_wall": [
        {
            "id": "starter_kelp_left_wall_top_lip",
            "type": "top_lip",
            "start": [-240, 676],
            "end": [70, 740],
            "offset": [0, -8],
            "repeat_spacing": 190,
            "scale": 0.18,
            "alpha": 0.46,
        },
        {
            "id": "starter_kelp_left_wall_outer_side",
            "type": "vertical_wall",
            "start": [-625, 730],
            "end": [-430, 1030],
            "offset": [-10, 0],
            "repeat_spacing": 220,
            "scale": 0.16,
            "alpha": 0.28,
        },
        {
            "id": "starter_kelp_left_wall_cave_slope",
            "type": "diagonal_slope",
            "start": [-80, 715],
            "end": [120, 1000],
            "offset": [10, 0],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.24,
        },
    ],
    "starter_shell_divider": [
        {
            "id": "starter_shell_divider_upper_lip",
            "type": "top_lip",
            "start": [780, 650],
            "end": [1120, 742],
            "offset": [0, -8],
            "repeat_spacing": 190,
            "scale": 0.18,
            "alpha": 0.44,
        },
        {
            "id": "starter_shell_divider_starter_side",
            "type": "vertical_wall",
            "start": [675, 820],
            "end": [650, 960],
            "offset": [-10, 0],
            "repeat_spacing": 200,
            "scale": 0.16,
            "alpha": 0.26,
        },
        {
            "id": "starter_shell_divider_shell_slope",
            "type": "diagonal_slope",
            "start": [1120, 742],
            "end": [1205, 935],
            "offset": [10, 0],
            "repeat_spacing": 210,
            "scale": 0.15,
            "alpha": 0.24,
        },
    ],
    "shell_reef_inner_ledges": [
        {
            "id": "shell_reef_inner_ledges_top_lip",
            "type": "top_lip",
            "start": [780, 1040],
            "end": [1425, 1005],
            "offset": [0, -8],
            "repeat_spacing": 210,
            "scale": 0.18,
            "alpha": 0.48,
        },
        {
            "id": "shell_reef_inner_ledges_underside",
            "type": "underside",
            "start": [875, 1170],
            "end": [1350, 1168],
            "offset": [0, 10],
            "repeat_spacing": 220,
            "scale": 0.16,
            "alpha": 0.3,
        },
    ],
    "thermal_vent_floor": [
        {
            "id": "thermal_vent_floor_top_lip",
            "type": "top_lip",
            "start": [1180, 1430],
            "end": [2610, 1420],
            "offset": [0, -10],
            "repeat_spacing": 260,
            "scale": 0.19,
            "alpha": 0.46,
        },
        {
            "id": "thermal_vent_floor_deep_lip",
            "type": "deep_floor_lip",
            "start": [1390, 1648],
            "end": [2580, 1690],
            "offset": [0, 12],
            "repeat_spacing": 260,
            "scale": 0.17,
            "alpha": 0.28,
        },
        {
            "id": "thermal_vent_floor_left_slope",
            "type": "diagonal_slope",
            "start": [1180, 1430],
            "end": [1390, 1370],
            "offset": [-8, -4],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.22,
        },
    ],
    "blue_chimney_west_wall": [
        {
            "id": "blue_chimney_west_wall_top_lip",
            "type": "top_lip",
            "start": [720, 1215],
            "end": [1120, 1280],
            "offset": [0, -8],
            "repeat_spacing": 200,
            "scale": 0.18,
            "alpha": 0.42,
        },
        {
            "id": "blue_chimney_west_wall_descent_side",
            "type": "vertical_wall",
            "start": [1095, 1530],
            "end": [1060, 2195],
            "offset": [10, 0],
            "repeat_spacing": 240,
            "scale": 0.16,
            "alpha": 0.28,
        },
        {
            "id": "blue_chimney_west_wall_entry_slope",
            "type": "diagonal_slope",
            "start": [560, 1420],
            "end": [720, 1215],
            "offset": [-8, 0],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.24,
        },
    ],
    "blue_chimney_floor": [
        {
            "id": "blue_chimney_floor_top_lip",
            "type": "top_lip",
            "start": [1040, 2200],
            "end": [3000, 2140],
            "offset": [0, -10],
            "repeat_spacing": 270,
            "scale": 0.18,
            "alpha": 0.4,
        },
        {
            "id": "blue_chimney_floor_deep_lip",
            "type": "deep_floor_lip",
            "start": [900, 2280],
            "end": [3110, 2380],
            "offset": [0, 12],
            "repeat_spacing": 280,
            "scale": 0.16,
            "alpha": 0.26,
        },
    ],
    "pressure_wreck_wall": [
        {
            "id": "pressure_wreck_wall_upper_lip",
            "type": "top_lip",
            "start": [3860, 760],
            "end": [4600, 825],
            "offset": [0, -8],
            "repeat_spacing": 230,
            "scale": 0.18,
            "alpha": 0.38,
        },
        {
            "id": "pressure_wreck_wall_outer_side",
            "type": "vertical_wall",
            "start": [4600, 825],
            "end": [4600, 1500],
            "offset": [10, 0],
            "repeat_spacing": 240,
            "scale": 0.16,
            "alpha": 0.24,
        },
        {
            "id": "pressure_wreck_wall_inner_slope",
            "type": "diagonal_slope",
            "start": [4040, 840],
            "end": [3930, 1000],
            "offset": [-8, 0],
            "repeat_spacing": 210,
            "scale": 0.15,
            "alpha": 0.22,
        },
    ],
    "pressure_wreck_inner_ceiling": [
        {
            "id": "pressure_wreck_inner_ceiling_underside",
            "type": "underside",
            "start": [3300, 940],
            "end": [3760, 1040],
            "offset": [0, 12],
            "repeat_spacing": 220,
            "scale": 0.16,
            "alpha": 0.28,
        },
        {
            "id": "pressure_wreck_inner_ceiling_right_slope",
            "type": "diagonal_slope",
            "start": [3860, 900],
            "end": [3760, 1040],
            "offset": [8, 0],
            "repeat_spacing": 200,
            "scale": 0.14,
            "alpha": 0.22,
        },
    ],
    "pressure_wreck_lower_shelf": [
        {
            "id": "pressure_wreck_lower_shelf_top_lip",
            "type": "top_lip",
            "start": [3000, 1320],
            "end": [3860, 1270],
            "offset": [0, -10],
            "repeat_spacing": 240,
            "scale": 0.18,
            "alpha": 0.36,
        },
        {
            "id": "pressure_wreck_lower_shelf_deep_lip",
            "type": "deep_floor_lip",
            "start": [3150, 1570],
            "end": [3860, 1580],
            "offset": [0, 12],
            "repeat_spacing": 250,
            "scale": 0.16,
            "alpha": 0.24,
        },
    ],
    "future_exit_ceiling": [
        {
            "id": "future_exit_ceiling_underside",
            "type": "underside",
            "start": [3120, 1745],
            "end": [4180, 1810],
            "offset": [0, 12],
            "repeat_spacing": 260,
            "scale": 0.16,
            "alpha": 0.24,
        },
        {
            "id": "future_exit_ceiling_right_side",
            "type": "vertical_wall",
            "start": [4540, 1585],
            "end": [4540, 1790],
            "offset": [10, 0],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.2,
        },
    ],
    "future_exit_endcap_wall": [
        {
            "id": "future_exit_endcap_wall_inner_face",
            "type": "vertical_wall",
            "start": [4405, 1850],
            "end": [4425, 2030],
            "offset": [-10, 0],
            "repeat_spacing": 210,
            "scale": 0.15,
            "alpha": 0.28,
        },
        {
            "id": "future_exit_endcap_wall_gate_lip",
            "type": "diagonal_slope",
            "start": [4390, 1950],
            "end": [4425, 2030],
            "offset": [-8, 0],
            "repeat_spacing": 180,
            "scale": 0.14,
            "alpha": 0.22,
        },
    ],
    "future_exit_left_pillar": [
        {
            "id": "future_exit_left_pillar_right_wall",
            "type": "vertical_wall",
            "start": [3100, 1760],
            "end": [3130, 2020],
            "offset": [10, 0],
            "repeat_spacing": 220,
            "scale": 0.15,
            "alpha": 0.24,
        },
        {
            "id": "future_exit_left_pillar_lower_lip",
            "type": "deep_floor_lip",
            "start": [2865, 2080],
            "end": [3020, 2120],
            "offset": [0, 10],
            "repeat_spacing": 180,
            "scale": 0.14,
            "alpha": 0.2,
        },
    ],
    "future_exit_floor": [
        {
            "id": "future_exit_floor_top_lip",
            "type": "top_lip",
            "start": [2920, 2070],
            "end": [4540, 2035],
            "offset": [0, -10],
            "repeat_spacing": 270,
            "scale": 0.18,
            "alpha": 0.32,
        },
        {
            "id": "future_exit_floor_deep_lip",
            "type": "deep_floor_lip",
            "start": [2880, 2400],
            "end": [4540, 2400],
            "offset": [0, 12],
            "repeat_spacing": 280,
            "scale": 0.16,
            "alpha": 0.22,
        },
        {
            "id": "future_exit_floor_left_slope",
            "type": "diagonal_slope",
            "start": [2865, 2220],
            "end": [2920, 2070],
            "offset": [-8, 0],
            "repeat_spacing": 210,
            "scale": 0.14,
            "alpha": 0.18,
        },
    ],
}


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def pascal_case(value: str) -> str:
    return "".join(part.capitalize() for part in re.split(r"[^a-zA-Z0-9]+", value) if part)


def copy_entry(entry: dict[str, Any]) -> dict[str, Any]:
    return copy.deepcopy(entry)


def polygon_bounds(points: list[list[float]]) -> dict[str, float]:
    xs = [float(point[0]) for point in points]
    ys = [float(point[1]) for point in points]
    return {
        "min_x": min(xs),
        "max_x": max(xs),
        "min_y": min(ys),
        "max_y": max(ys),
    }


def point_in_polygon(point: tuple[float, float], polygon: list[list[float]]) -> bool:
    inside = False
    x, y = point
    previous = len(polygon) - 1
    for index, current_point in enumerate(polygon):
        current_x, current_y = float(current_point[0]), float(current_point[1])
        previous_x, previous_y = float(polygon[previous][0]), float(polygon[previous][1])
        crosses = (current_y > y) != (previous_y > y) and x < (
            (previous_x - current_x) * (y - current_y) / (previous_y - current_y) + current_x
        )
        if crosses:
            inside = not inside
        previous = index
    return inside


def point_in_rect(point: list[float], rect: tuple[float, float, float, float]) -> bool:
    x, y = float(point[0]), float(point[1])
    x0, y0, x1, y1 = rect
    return x0 <= x <= x1 and y0 <= y <= y1


def _orientation(
    a: tuple[float, float],
    b: tuple[float, float],
    c: tuple[float, float],
) -> float:
    return (b[1] - a[1]) * (c[0] - b[0]) - (b[0] - a[0]) * (c[1] - b[1])


def _on_segment(
    a: tuple[float, float],
    b: tuple[float, float],
    c: tuple[float, float],
) -> bool:
    return (
        min(a[0], c[0]) <= b[0] <= max(a[0], c[0])
        and min(a[1], c[1]) <= b[1] <= max(a[1], c[1])
    )


def segments_intersect(
    a: tuple[float, float],
    b: tuple[float, float],
    c: tuple[float, float],
    d: tuple[float, float],
) -> bool:
    o1 = _orientation(a, b, c)
    o2 = _orientation(a, b, d)
    o3 = _orientation(c, d, a)
    o4 = _orientation(c, d, b)
    epsilon = 0.0001
    if abs(o1) < epsilon and _on_segment(a, c, b):
        return True
    if abs(o2) < epsilon and _on_segment(a, d, b):
        return True
    if abs(o3) < epsilon and _on_segment(c, a, d):
        return True
    if abs(o4) < epsilon and _on_segment(c, b, d):
        return True
    return (o1 > 0) != (o2 > 0) and (o3 > 0) != (o4 > 0)


def cell_intersects_polygon(
    rect: tuple[float, float, float, float],
    polygon: list[list[float]],
) -> bool:
    x0, y0, x1, y1 = rect
    cell_points = [(x0, y0), (x1, y0), (x1, y1), (x0, y1)]
    center = ((x0 + x1) * 0.5, (y0 + y1) * 0.5)
    if point_in_polygon(center, polygon):
        return True
    if any(point_in_polygon(point, polygon) for point in cell_points):
        return True
    if any(point_in_rect(point, rect) for point in polygon):
        return True

    cell_edges = list(zip(cell_points, cell_points[1:] + cell_points[:1]))
    poly_points = [(float(point[0]), float(point[1])) for point in polygon]
    poly_edges = list(zip(poly_points, poly_points[1:] + poly_points[:1]))
    return any(segments_intersect(a, b, c, d) for a, b in cell_edges for c, d in poly_edges)


def runtime_terrain_domain_entry() -> dict[str, Any]:
    domain = copy_entry(TERRAIN_DOMAIN)
    domain["runtime_generation"] = {
        "visible_polygon2d_name": "ContinuousUnderseaTerrainDomain",
        "water_cutout_layer_name": "RuntimeSourceWaterCutouts",
        "edge_line_layer_name": "RuntimeSourceWaterEdges",
        "visual_role": "continuous_terrain_domain",
        "source": "terrain_domain polygon",
        "sprites_define_collision": False,
    }
    return domain


def runtime_playable_water_region(
    entry_id: str,
    role: str,
    kind: str,
    polygon: list[list[float]],
    source_path: str,
    source_region_id: str,
    status: str,
    carves_collision: bool,
    connects_to: list[str] | None = None,
    source_region_ids: list[str] | None = None,
) -> dict[str, Any]:
    node_name = pascal_case(entry_id)
    region_ids = source_region_ids or ([source_region_id] if source_region_id else [])
    return {
        "id": entry_id,
        "role": role,
        "kind": kind,
        "polygon": copy.deepcopy(polygon),
        "source": source_path,
        "source_region_id": source_region_id,
        "source_region_ids": region_ids,
        "status": status,
        "connects_to": connects_to or [],
        "carves_collision": carves_collision,
        "runtime_generation": {
            "visible_polygon2d_name": f"{node_name}WaterCutout",
            "edge_line2d_name": f"{node_name}WaterEdge",
            "visual_role": "playable_water_cutout",
            "collision_effect": "subtract_from_terrain_domain" if carves_collision else "open_surface_reference_only",
            "sprites_define_collision": False,
        },
    }


def runtime_playable_water_regions(
    geometry: dict[str, Any],
    playable_water_trace: dict[str, Any] | None = None,
) -> list[dict[str, Any]]:
    water_regions: list[dict[str, Any]] = []
    for region in geometry["regions"]:
        kind = str(region.get("kind", ""))
        if kind != "open_surface":
            continue
        region_id = str(region["id"])
        water_regions.append(
            runtime_playable_water_region(
                f"{region_id}_water",
                str(region.get("role", region.get("display_name", region_id))),
                kind,
                region["approx_polygon"],
                "regions.approx_polygon",
                region_id,
                str(region.get("status", "planned")),
                False,
                [str(value) for value in region.get("connects_to", [])],
            )
        )

    if playable_water_trace is not None:
        for traced_region in playable_water_trace.get("playable_water_regions", []):
            source_region_ids = [str(value) for value in traced_region.get("source_region_ids", [])]
            source_region_id = source_region_ids[0] if source_region_ids else ""
            water_regions.append(
                runtime_playable_water_region(
                    str(traced_region["id"]),
                    str(traced_region.get("role", traced_region.get("display_name", traced_region["id"]))),
                    str(traced_region.get("kind", "source_png_trace")),
                    traced_region["polygon"],
                    "area_01_playable_water_trace_v1.playable_water_regions.polygon",
                    source_region_id,
                    str(traced_region.get("status", "planned")),
                    bool(traced_region.get("carves_terrain_collision", True)),
                    source_region_ids,
                    source_region_ids,
                )
            )
    else:
        for region in geometry["regions"]:
            kind = str(region.get("kind", ""))
            if kind not in CARVING_REGION_KINDS:
                continue
            region_id = str(region["id"])
            water_regions.append(
                runtime_playable_water_region(
                    f"{region_id}_water",
                    str(region.get("role", region.get("display_name", region_id))),
                    kind,
                    region["approx_polygon"],
                    "regions.approx_polygon",
                    region_id,
                    str(region.get("status", "planned")),
                    True,
                    [str(value) for value in region.get("connects_to", [])],
                )
            )

    for cave_mouth in geometry["cave_mouths"]:
        mouth_id = str(cave_mouth["id"])
        target_region = str(cave_mouth.get("to_region", ""))
        status = "future_locked" if target_region == "future_deep_exit" else str(cave_mouth.get("status", "planned"))
        water_regions.append(
            runtime_playable_water_region(
                f"{mouth_id}_water",
                str(cave_mouth.get("readability_role", f"{mouth_id} playable cave-mouth water.")),
                "cave_mouth",
                cave_mouth["entrance_polygon"],
                "cave_mouths.entrance_polygon",
                target_region,
                status,
                True,
                [str(cave_mouth.get("from_region", "")), target_region],
            )
        )

    return water_regions


def generated_collision_partition_entry(
    rect: dict[str, float],
    index: int,
    carving_region_ids: list[str],
) -> dict[str, Any]:
    terrain_id = f"generated_solid_partition_{index:03d}"
    node_name = pascal_case(terrain_id)
    polygon = [
        [round(rect["x0"], 3), round(rect["y0"], 3)],
        [round(rect["x1"], 3), round(rect["y0"], 3)],
        [round(rect["x1"], 3), round(rect["y1"], 3)],
        [round(rect["x0"], 3), round(rect["y1"], 3)],
    ]
    return {
        "id": terrain_id,
        "role": "Generated collision partition for the continuous terrain domain outside playable water.",
        "polygon": polygon,
        "visual_strategy": "Collision-only partition; continuous terrain_domain and playable_water_regions own the visible mass/cutout read.",
        "collision_strategy": "CollisionPolygon2D from deterministic water-shape carve grid.",
        "rim_strategy": "No per-partition rim; water-region edge cues own readable cave boundaries.",
        "blocks_player": True,
        "generation_source": {
            "algorithm": "terrain_domain_minus_playable_water_grid_v1",
            "terrain_domain": TERRAIN_DOMAIN["id"],
            "cell_size": GRID_CELL_SIZE,
            "carved_playable_water_regions": carving_region_ids,
        },
        "runtime_generation": {
            "visual_role": "collision_partition",
            "collision_static_body2d_name": "RuntimeSourceCollision",
            "collision_polygon2d_name": f"{node_name}Collision",
            "collision_points_source": "this polygon",
            "sprites_define_collision": False,
        },
    }


def generated_collision_partitions(water_regions: list[dict[str, Any]]) -> list[dict[str, Any]]:
    domain_bounds = polygon_bounds(TERRAIN_DOMAIN["polygon"])
    carve_regions = [entry for entry in water_regions if entry.get("carves_collision")]
    carve_polygons = [entry["polygon"] for entry in carve_regions]
    carving_region_ids = [str(entry["id"]) for entry in carve_regions]

    rows: list[list[dict[str, float]]] = []
    y = domain_bounds["min_y"]
    while y < domain_bounds["max_y"]:
        y1 = min(y + GRID_CELL_SIZE, domain_bounds["max_y"])
        row_runs: list[dict[str, float]] = []
        current_run: dict[str, float] | None = None
        x = domain_bounds["min_x"]
        while x < domain_bounds["max_x"]:
            x1 = min(x + GRID_CELL_SIZE, domain_bounds["max_x"])
            rect = (x, y, x1, y1)
            is_water = any(cell_intersects_polygon(rect, polygon) for polygon in carve_polygons)
            if not is_water and current_run is None:
                current_run = {"x0": x, "x1": x1, "y0": y, "y1": y1}
            elif not is_water and current_run is not None:
                current_run["x1"] = x1
            elif is_water and current_run is not None:
                row_runs.append(current_run)
                current_run = None
            x = x1
        if current_run is not None:
            row_runs.append(current_run)
        rows.append(row_runs)
        y = y1

    rectangles: list[dict[str, float]] = []
    active: dict[tuple[float, float], dict[str, float]] = {}
    for row in rows:
        next_active: dict[tuple[float, float], dict[str, float]] = {}
        used_keys: set[tuple[float, float]] = set()
        for run in row:
            key = (run["x0"], run["x1"])
            if key in active and abs(active[key]["y1"] - run["y0"]) < 0.001:
                active[key]["y1"] = run["y1"]
                next_active[key] = active[key]
                used_keys.add(key)
            else:
                next_active[key] = copy.deepcopy(run)
        for key, rect in active.items():
            if key not in used_keys:
                rectangles.append(rect)
        active = next_active
    rectangles.extend(active.values())

    rectangles.sort(key=lambda item: (item["y0"], item["x0"], item["y1"], item["x1"]))
    return [
        generated_collision_partition_entry(rect, index + 1, carving_region_ids)
        for index, rect in enumerate(rectangles)
    ]


def runtime_terrain_entry(entry: dict[str, Any]) -> dict[str, Any]:
    terrain = copy_entry(entry)
    node_name = pascal_case(entry["id"])
    if entry["id"] in SEMANTIC_TRIM_SEGMENTS:
        terrain["trim_segments"] = copy.deepcopy(SEMANTIC_TRIM_SEGMENTS[entry["id"]])
    terrain["runtime_generation"] = {
        "visible_polygon2d_name": f"{node_name}Terrain",
        "collision_static_body2d_name": f"{node_name}Solid",
        "collision_polygon2d_name": f"{node_name}Collision",
        "rim_container_name": f"{node_name}Rims",
        "sprite_trim_source": "docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json",
        "collision_points_source": "this polygon",
        "sprites_define_collision": False,
    }
    return terrain


def runtime_hook_entry(entry: dict[str, Any]) -> dict[str, Any]:
    hook = copy_entry(entry)
    hook_name = pascal_case(entry["id"])
    hook["runtime_generation"] = {
        "area2d_name": f"{hook_name}Area",
        "collision_polygon2d_name": f"{hook_name}Trigger",
        "points_source": "this hook points",
        "owner_system": entry.get("owner", "unassigned"),
        "blocks_player": False,
    }
    return hook


def runtime_scene_hooks(geometry: dict[str, Any]) -> list[dict[str, Any]]:
    hooks = [runtime_hook_entry(entry) for entry in geometry["scene_hooks"]]
    existing_hook_ids = {entry["id"] for entry in hooks}

    for cave_mouth in geometry["cave_mouths"]:
        scene_hook_id = cave_mouth.get("scene_hook", "")
        if not scene_hook_id or scene_hook_id in existing_hook_ids:
            continue

        region_id = cave_mouth.get("to_region", cave_mouth.get("from_region", ""))
        status = "future_locked" if region_id == "future_deep_exit" else "planned"
        hooks.append(
            runtime_hook_entry(
                {
                    "id": scene_hook_id,
                    "type": "cave_entrance",
                    "region_id": region_id,
                    "shape": "polygon",
                    "points": copy.deepcopy(cave_mouth.get("entrance_polygon", [])),
                    "owner": "future cave entrance metadata",
                    "status": status,
                }
            )
        )
        existing_hook_ids.add(scene_hook_id)

    return hooks


def merge_validation_rules(
    blockout: dict[str, Any],
    geometry: dict[str, Any],
) -> list[dict[str, str]]:
    merged: dict[str, str] = {}
    for item in blockout.get("validation_rules", []):
        if isinstance(item, dict):
            merged[item["id"]] = item["rule"]
        else:
            key = re.sub(r"[^a-z0-9]+", "_", str(item).lower()).strip("_")[:80]
            merged[key] = str(item)
    for item in geometry.get("validation_rules", []):
        key = re.sub(r"[^a-z0-9]+", "_", str(item).lower()).strip("_")[:80]
        merged.setdefault(key, str(item))
    merged["promoted_runtime_v3_surface_floor_single_source"] = (
        "Runtime v3 terrain visuals, collision polygons, rim trims, interaction hooks, debug overlays, and previews must derive from this surface-floor source map."
    )
    merged["do_not_bake_preview_png"] = (
        "Preview PNGs are QA artifacts only and must not be used as the runtime map."
    )
    merged["open_surface_must_span_stage"] = (
        "The top water surface must remain open across the full stage for repeated oxygen recovery during the day run."
    )
    merged["ship_offload_is_not_surface_oxygen"] = (
        "The ship/moonpool offload hook must stay separate from the broad surface oxygen refill band."
    )
    merged["placements_must_not_overlap_solid_terrain"] = (
        "Resource pickups, fish, scannables, gates, hazards, and route hooks must be placed in playable water regions, not inside solid terrain polygons."
    )
    merged["playable_water_regions_are_primary_source"] = (
        "Area 01 runtime topology must treat playable_water_regions and cave_mouths as the primary geometry input; hand-authored solid chunks are not the design source."
    )
    merged["playable_water_trace_required"] = (
        "Area 01 cave/corridor/pocket playable-water regions must be regenerated from docs/planning/maps/area_01_surface_floor_source_map_v1.png through area_01_playable_water_trace_v1.json before runtime v3 is regenerated."
    )
    merged["runtime_solids_generated_from_playable_water"] = (
        "Runtime solid_terrain entries must be deterministic collision partitions generated from terrain_domain minus playable_water_regions."
    )
    merged["terrain_domain_must_be_continuous_under_surface"] = (
        "The undersea terrain domain must remain one continuous mass below the open surface, with caves represented as carved playable-water holes."
    )
    merged["topology_parity_render_required"] = (
        "Area 01 map-truth changes must refresh the runtime-vs-source side-by-side render so sparse floating terrain cannot be mistaken for source parity."
    )
    return [{"id": key, "rule": value} for key, value in merged.items()]


def runtime_comparison_summary() -> list[dict[str, str]]:
    return [
        {
            "topic": "surface oxygen",
            "source_truth": "Open horizontal surface-water band spans the full stage above the seafloor.",
            "runtime_v3": "Keeps the surface water open and treats ship/moonpool banking as explicit hooks, not enclosing cave topology.",
            "parity_result": "Matched at topology level.",
        },
        {
            "topic": "terrain topology",
            "source_truth": "Continuous gray undersea terrain mass with white playable cave corridors and pockets carved through it.",
            "runtime_v3": "Builds one terrain_domain visual and generates collision partitions from terrain_domain minus source-PNG-traced playable_water_regions.",
            "parity_result": "Matched at topology level; generated partitions are collision implementation details, not primary design chunks.",
        },
        {
            "topic": "interaction model",
            "source_truth": "Resources, oxygen/offload, cave entrances, gates, hazards, scans, and return currents are explicit map hooks.",
            "runtime_v3": "Carries scene_hooks, sprite_placements, cave_mouths, and validation metadata forward from accepted geometry.",
            "parity_result": "Matched for source-driven placement rules; runtime visuals remain blockout-quality art.",
        },
        {
            "topic": "runtime wiring",
            "source_truth": "Future uploaded/source maps must become editable Godot geometry deterministically.",
            "runtime_v3": "Generator owns terrain_domain, playable_water_regions, solid collision partitions, hook metadata, and preview renders.",
            "parity_result": "Matched for deterministic source-to-runtime generation.",
        },
    ]


def main() -> None:
    geometry = load_json(ACCEPTED_GEOMETRY_PATH)
    blockout = load_json(CURRENT_BLOCKOUT_PATH)
    comparison = load_json(COMPARISON_PATH)
    terrain_kit = load_json(TERRAIN_KIT_MANIFEST_PATH)
    surface_source = load_json(SURFACE_SOURCE_PATH)
    surface_objects = load_json(SURFACE_OBJECTS_PATH)
    playable_water_trace = load_json(PLAYABLE_WATER_TRACE_PATH) if PLAYABLE_WATER_TRACE_PATH.exists() else None
    playable_water = runtime_playable_water_regions(geometry, playable_water_trace)
    solid_partitions = generated_collision_partitions(playable_water)
    coordinate_space = copy_entry(geometry["coordinate_space"])
    coordinate_space["runtime_authority"] = (
        "Current Area 01 geometry/collision authority. Main.tscn calls Area01BlockoutBuilder, "
        "which builds runtime terrain, collision, rims, and validation hooks from this file; "
        "this runtime v3 file is generated from playable-water regions carved through one continuous terrain domain."
    )
    coordinate_space["source_visual_reference"] = str(SURFACE_SOURCE_PATH.relative_to(ROOT)).replace("\\", "/")

    output = {
        "schema_version": 1,
        "map_id": "area_01_runtime_source_map_v3",
        "date": "2026-06-30",
        "status": "active_runtime_surface_floor_geometry_collision_authority",
        "purpose": (
            "Single promoted Area 01 source map for runtime v3. This makes the uploaded "
            "open-surface-over-seafloor-with-dive-holes plan the runtime geometry/collision contract. "
            "It merges the surface-floor source reference, Godot-coordinate geometry, explicit scene "
            "hooks, object placement metadata, terrain-kit references, and defect-prevention rules."
        ),
        "source_inputs": {
            "surface_floor_source_reference": str(SURFACE_SOURCE_PATH.relative_to(ROOT)).replace("\\", "/"),
            "accepted_geometry": str(ACCEPTED_GEOMETRY_PATH.relative_to(ROOT)).replace("\\", "/"),
            "surface_floor_object_layer": str(SURFACE_OBJECTS_PATH.relative_to(ROOT)).replace("\\", "/"),
            "playable_water_trace": str(PLAYABLE_WATER_TRACE_PATH.relative_to(ROOT)).replace("\\", "/"),
            "legacy_runtime_blockout": str(CURRENT_BLOCKOUT_PATH.relative_to(ROOT)).replace("\\", "/"),
            "map_truth_comparison": str(COMPARISON_PATH.relative_to(ROOT)).replace("\\", "/"),
            "terrain_kit_manifest": str(TERRAIN_KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
        },
        "generation_model": {
            "strategy": "playable_water_first",
            "primary_source": "area_01_playable_water_trace_v1 playable-water polygons plus cave_mouths.entrance_polygon from area_01_surface_floor_geometry_v1.json",
            "terrain_policy": "Generate solid collision partitions from terrain_domain minus playable_water_regions.",
            "solid_terrain_policy": "Do not copy hand-authored solid_terrain chunks as the primary design source.",
            "grid_cell_size": GRID_CELL_SIZE,
            "determinism": "Same input geometry produces the same terrain_domain, playable_water_regions, generated solid partitions, hook metadata, and preview renders.",
        },
        "playable_water_trace": {
            "source": str(PLAYABLE_WATER_TRACE_PATH.relative_to(ROOT)).replace("\\", "/"),
            "status": playable_water_trace.get("status", "missing") if playable_water_trace else "missing",
            "region_count": len(playable_water_trace.get("playable_water_regions", [])) if playable_water_trace else 0,
        },
        "promotion_decision": {
            "accepted_direction": "area_01_surface_floor_source_map_v1 plus area_01_surface_floor_geometry_v1 plus area_01_terrain_art_kit_v4",
            "current_runtime_replaced_when": "Main.tscn calls the Godot builder, which creates visible terrain, collision, rims, and nonblocking debug hooks from this file during startup.",
            "old_blockout_policy": "area_01_blockout_source_map_v1.json and accepted_geometry.solid_terrain are historical/reference material only; runtime v3 derives topology from playable water carved through the terrain domain.",
            "user_visible_acceptance": surface_source.get("topology_rule", ""),
            "comparison_summary": runtime_comparison_summary(),
        },
        "coordinate_space": coordinate_space,
        "pipeline": geometry["pipeline"],
        "topology": geometry["topology"],
        "terrain_kit": {
            "manifest": str(TERRAIN_KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
            "atlas": terrain_kit["atlas"],
            "frame_directory": terrain_kit["frame_directory"],
            "sprites_define_collision": False,
        },
        "runtime_generation_contract": {
            "terrain_fill_node": "Polygon2D",
            "solid_collision_nodes": ["StaticBody2D", "CollisionPolygon2D"],
            "terrain_trim_node": "Line2D or Sprite2D",
            "trigger_node": "Area2D",
            "hook_collision_node": "CollisionPolygon2D",
            "collision_source": "generated solid_terrain collision partitions from terrain_domain minus playable_water_regions, plus scene_hooks points",
            "visual_source": "terrain kit manifest plus generated props, not preview PNG pixels",
            "rule": "continuous terrain_domain visual plus playable_water_regions cutouts are the topology read; generated solid_terrain partitions own blocking collision only.",
        },
        "terrain_domain": runtime_terrain_domain_entry(),
        "playable_water_regions": playable_water,
        "regions": [copy_entry(entry) for entry in geometry["regions"]],
        "solid_terrain": solid_partitions,
        "cave_mouths": [copy_entry(entry) for entry in geometry["cave_mouths"]],
        "sprite_placements": [copy_entry(entry) for entry in geometry["sprite_placements"]],
        "object_layer": copy_entry(surface_objects),
        "scene_hooks": runtime_scene_hooks(geometry),
        "camera_bounds": copy_entry(geometry["camera_bounds"]),
        "validation_rules": merge_validation_rules(blockout, geometry),
        "migration_plan": [
            {
                "step": 1,
                "task": "Generate preview from this file and verify it matches the uploaded open-surface, seafloor, cave-hole direction.",
                "status": "complete",
            },
            {
                "step": 2,
                "task": "Build or update the Godot Area 01 builder to create terrain Polygon2D, StaticBody2D/CollisionPolygon2D, rim/trim Sprite2D, and Area2D hooks from this file.",
                "status": "complete",
            },
            {
                "step": 3,
                "task": "Run collision/debug overlay validation that proves visible terrain, collision, and rim trims share source polygons.",
                "status": "complete",
            },
            {
                "step": 4,
                "task": "Mark this file as runtime authority and demote the old blockout map to historical fallback material.",
                "status": "complete",
            },
        ],
        "non_goals": [
            "No baked preview PNG runtime map.",
            "No new route content, creatures, upgrades, resources, or gameplay promises in this source-map promotion.",
            "No collision inferred from sprite alpha or generated pixels.",
            "No final production art guarantee; v4 remains a prototype terrain-art direction.",
        ],
    }

    OUTPUT_PATH.write_text(json.dumps(output, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(OUTPUT_PATH)


if __name__ == "__main__":
    main()
