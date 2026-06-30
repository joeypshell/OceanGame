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
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_runtime_source_map_v3.json"

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
    return [{"id": key, "rule": value} for key, value in merged.items()]


def main() -> None:
    geometry = load_json(ACCEPTED_GEOMETRY_PATH)
    blockout = load_json(CURRENT_BLOCKOUT_PATH)
    comparison = load_json(COMPARISON_PATH)
    terrain_kit = load_json(TERRAIN_KIT_MANIFEST_PATH)
    surface_source = load_json(SURFACE_SOURCE_PATH)
    surface_objects = load_json(SURFACE_OBJECTS_PATH)
    coordinate_space = copy_entry(geometry["coordinate_space"])
    coordinate_space["runtime_authority"] = (
        "Current Area 01 geometry/collision authority. Main.tscn calls Area01BlockoutBuilder, "
        "which builds runtime terrain, collision, rims, and validation hooks from this file; "
        "this runtime v3 file is promoted from the uploaded surface-floor source map and its Godot-coordinate geometry."
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
            "legacy_runtime_blockout": str(CURRENT_BLOCKOUT_PATH.relative_to(ROOT)).replace("\\", "/"),
            "map_truth_comparison": str(COMPARISON_PATH.relative_to(ROOT)).replace("\\", "/"),
            "terrain_kit_manifest": str(TERRAIN_KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
        },
        "promotion_decision": {
            "accepted_direction": "area_01_surface_floor_source_map_v1 plus area_01_surface_floor_geometry_v1 plus area_01_terrain_art_kit_v4",
            "current_runtime_replaced_when": "Main.tscn calls the Godot builder, which creates visible terrain, collision, rims, and nonblocking debug hooks from this file during startup.",
            "old_blockout_policy": "area_01_blockout_source_map_v1.json is historical fallback material only; runtime v3 is the current geometry/collision source.",
            "user_visible_acceptance": surface_source.get("topology_rule", ""),
            "comparison_summary": comparison["semantic_comparison"],
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
            "terrain_trim_node": "Sprite2D",
            "trigger_node": "Area2D",
            "hook_collision_node": "CollisionPolygon2D",
            "collision_source": "solid_terrain polygon points and scene_hooks points",
            "visual_source": "terrain kit manifest plus generated props, not preview PNG pixels",
            "rule": "visible terrain polygon == collision polygon source == rim/trim placement source for every solid terrain entry",
        },
        "regions": [copy_entry(entry) for entry in geometry["regions"]],
        "solid_terrain": [runtime_terrain_entry(entry) for entry in geometry["solid_terrain"]],
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
