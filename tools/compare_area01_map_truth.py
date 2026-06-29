from __future__ import annotations

import json
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
RUNTIME_BLOCKOUT_PATH = ROOT / "docs/planning/maps/area_01_blockout_source_map_v1.json"
ACCEPTED_GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_geometry_v1.json"
SURFACE_REFERENCE_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_source_map_v1.json"
TERRAIN_KIT_MANIFEST_PATH = ROOT / "docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json"
OUTPUT_PATH = ROOT / "docs/planning/maps/area_01_map_truth_comparison_v1.json"


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def polygon_area(points: list[list[float]]) -> float:
    total = 0.0
    for index, point in enumerate(points):
        next_point = points[(index + 1) % len(points)]
        total += point[0] * next_point[1] - next_point[0] * point[1]
    return abs(total) * 0.5


def polygon_bounds(points: list[list[float]]) -> dict[str, float]:
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    return {
        "min_x": min(xs),
        "min_y": min(ys),
        "max_x": max(xs),
        "max_y": max(ys),
        "width": max(xs) - min(xs),
        "height": max(ys) - min(ys),
    }


def summarize_polygons(entries: list[dict[str, Any]], polygon_key: str) -> list[dict[str, Any]]:
    summaries: list[dict[str, Any]] = []
    for entry in entries:
        points = entry[polygon_key]
        summaries.append(
            {
                "id": entry["id"],
                "role": entry.get("role") or entry.get("display_name") or entry.get("kind") or "",
                "vertices": len(points),
                "bounds": polygon_bounds(points),
                "area": round(polygon_area(points), 2),
            }
        )
    return summaries


def combined_bounds(poly_summaries: list[dict[str, Any]]) -> dict[str, float]:
    bounds = [entry["bounds"] for entry in poly_summaries]
    min_x = min(entry["min_x"] for entry in bounds)
    min_y = min(entry["min_y"] for entry in bounds)
    max_x = max(entry["max_x"] for entry in bounds)
    max_y = max(entry["max_y"] for entry in bounds)
    return {
        "min_x": min_x,
        "min_y": min_y,
        "max_x": max_x,
        "max_y": max_y,
        "width": max_x - min_x,
        "height": max_y - min_y,
    }


def main() -> None:
    runtime_blockout = load_json(RUNTIME_BLOCKOUT_PATH)
    accepted_geometry = load_json(ACCEPTED_GEOMETRY_PATH)
    surface_reference = load_json(SURFACE_REFERENCE_PATH)
    terrain_kit_manifest = load_json(TERRAIN_KIT_MANIFEST_PATH)

    runtime_terrain = summarize_polygons(runtime_blockout["solid_terrain"], "polygon")
    accepted_terrain = summarize_polygons(accepted_geometry["solid_terrain"], "polygon")
    runtime_lanes = summarize_polygons(runtime_blockout["playable_water_lanes"], "approx_polygon")
    accepted_regions = summarize_polygons(accepted_geometry["regions"], "approx_polygon")

    comparison = {
        "schema_version": 1,
        "id": "area_01_map_truth_comparison_v1",
        "date": "2026-06-29",
        "status": "comparison_only_not_runtime_wired",
        "decision_context": {
            "accepted_visual_geometry_direction": str(ACCEPTED_GEOMETRY_PATH.relative_to(ROOT)).replace("\\", "/"),
            "accepted_visual_terrain_kit": str(TERRAIN_KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
            "current_runtime_authority": str(RUNTIME_BLOCKOUT_PATH.relative_to(ROOT)).replace("\\", "/"),
            "high_level_surface_reference": str(SURFACE_REFERENCE_PATH.relative_to(ROOT)).replace("\\", "/"),
        },
        "pipeline_contract": {
            "map_mode": "side_scroll_mode",
            "visual_model": "parallax_layers plus source-map terrain chunks",
            "runtime_object_model": "platform_objects plus interactive_scene_objects plus foreground_occluders plus scene_hooks",
            "collision_model": "precise_shapes plus trigger_zones",
            "rule": "Do not infer collision from generated art; solid terrain, collision, visible fills, and rim trims must derive from the same source-map polygons.",
        },
        "source_counts": {
            "runtime_blockout": {
                "solid_terrain": len(runtime_blockout["solid_terrain"]),
                "playable_water_lanes": len(runtime_blockout["playable_water_lanes"]),
                "resource_pockets": len(runtime_blockout.get("resource_pockets", [])),
                "cave_mouth_affordances": len(runtime_blockout.get("cave_mouth_affordances", [])),
            },
            "accepted_surface_floor": {
                "solid_terrain": len(accepted_geometry["solid_terrain"]),
                "regions": len(accepted_geometry["regions"]),
                "cave_mouths": len(accepted_geometry["cave_mouths"]),
                "sprite_placements": len(accepted_geometry["sprite_placements"]),
                "scene_hooks": len(accepted_geometry["scene_hooks"]),
            },
        },
        "source_extents": {
            "runtime_blockout_solid_terrain": combined_bounds(runtime_terrain),
            "accepted_surface_floor_solid_terrain": combined_bounds(accepted_terrain),
            "runtime_blockout_playable_lanes": combined_bounds(runtime_lanes),
            "accepted_surface_floor_regions": combined_bounds(accepted_regions),
        },
        "runtime_blockout_terrain": runtime_terrain,
        "accepted_surface_floor_terrain": accepted_terrain,
        "runtime_blockout_lanes": runtime_lanes,
        "accepted_surface_floor_regions": accepted_regions,
        "semantic_comparison": [
            {
                "topic": "surface oxygen",
                "runtime_blockout": "Models a boat/moonpool surface-entry lane and central descent spine.",
                "accepted_surface_floor": "Models an open horizontal surface-water band across the full stage plus a separate oxygen refill hook.",
                "reconciliation": "The promoted map should use the accepted open-surface rule, while preserving ship/moonpool banking as a separate offload hook.",
            },
            {
                "topic": "terrain topology",
                "runtime_blockout": "Uses rescue-pass wall masses and water lanes to make current collision readable.",
                "accepted_surface_floor": "Uses continuous seafloor shelf segments with cave holes and named cave systems below.",
                "reconciliation": "Use accepted surface-floor terrain as the base for runtime v2; retire direct blockout wall topology after migration.",
            },
            {
                "topic": "interaction model",
                "runtime_blockout": "Uses resource pockets, cave-mouth affordances, and validation rules.",
                "accepted_surface_floor": "Uses explicit scene_hooks for oxygen, offload, cave entrances, hazards, gates, pickups, scans, and return currents.",
                "reconciliation": "Promoted runtime source should use explicit scene_hooks and preserve relevant blockout defect-prevention validation rules.",
            },
            {
                "topic": "runtime wiring",
                "runtime_blockout": "Contains existing visible_path, collision_path, and lip_path fields for current runtime builder nodes.",
                "accepted_surface_floor": "Contains visual/collision/rim strategies but no current scene node paths because it is not runtime-wired.",
                "reconciliation": "The next implementation pass needs a builder or conversion layer that creates visible terrain, collision, rim trims, and Area2D hooks from accepted geometry.",
            },
        ],
        "recommended_next_artifact": {
            "path": "docs/planning/maps/area_01_runtime_source_map_v2.json",
            "purpose": "Single promoted source of truth that merges accepted surface-floor geometry with runtime-ready builder metadata and validation rules.",
            "should_include": [
                "solid_terrain polygons copied from accepted surface-floor geometry",
                "scene_hooks copied from accepted surface-floor geometry",
                "runtime builder naming or node-generation templates",
                "validation rules inherited from both current blockout and accepted geometry",
                "terrain kit manifest pointer",
                "explicit statement that sprites do not define collision",
            ],
        },
        "must_not_do": [
            "Do not wire the v3 preview PNG as a baked runtime map.",
            "Do not keep runtime collision on the old blockout while showing the accepted surface-floor terrain art.",
            "Do not hand-place visual walls that are not generated from the promoted source polygons.",
            "Do not infer cave-mouth blockers or routes from sprite pixels.",
        ],
        "source_reference_topology_rule": surface_reference["topology_rule"],
        "terrain_kit_status": terrain_kit_manifest["status"],
    }

    OUTPUT_PATH.write_text(json.dumps(comparison, indent=2), encoding="utf-8")
    print(OUTPUT_PATH)


if __name__ == "__main__":
    main()
