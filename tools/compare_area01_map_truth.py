from __future__ import annotations

import json
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
RUNTIME_BLOCKOUT_PATH = ROOT / "docs/planning/maps/area_01_blockout_source_map_v1.json"
ACCEPTED_GEOMETRY_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_geometry_v1.json"
SURFACE_REFERENCE_PATH = ROOT / "docs/planning/maps/area_01_surface_floor_source_map_v1.json"
TERRAIN_KIT_MANIFEST_PATH = ROOT / "docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json"
RUNTIME_SOURCE_MAP_V3_PATH = ROOT / "docs/planning/maps/area_01_runtime_source_map_v3.json"
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
        "date": "2026-06-30",
        "status": "historical_comparison_runtime_v3_supersedes_sparse_blockout",
        "decision_context": {
            "accepted_visual_geometry_direction": str(ACCEPTED_GEOMETRY_PATH.relative_to(ROOT)).replace("\\", "/"),
            "accepted_visual_terrain_kit": str(TERRAIN_KIT_MANIFEST_PATH.relative_to(ROOT)).replace("\\", "/"),
            "historical_runtime_blockout": str(RUNTIME_BLOCKOUT_PATH.relative_to(ROOT)).replace("\\", "/"),
            "current_runtime_authority": str(RUNTIME_SOURCE_MAP_V3_PATH.relative_to(ROOT)).replace("\\", "/"),
            "high_level_surface_reference": str(SURFACE_REFERENCE_PATH.relative_to(ROOT)).replace("\\", "/"),
        },
        "pipeline_contract": {
            "map_mode": "side_scroll_mode",
            "visual_model": "parallax_layers plus continuous terrain_domain with playable-water cave cutouts",
            "runtime_object_model": "platform_objects plus interactive_scene_objects plus foreground_occluders plus scene_hooks",
            "collision_model": "generated solid partitions from terrain_domain minus playable_water_regions plus trigger_zones",
            "rule": "Do not infer collision from generated art; terrain visuals, playable-water cutouts, collision partitions, and rim trims must derive from the same source-map polygons.",
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
                "runtime_blockout": "Historical blockout modeled a boat/moonpool surface-entry lane and central descent spine.",
                "accepted_surface_floor": "Models an open horizontal surface-water band across the full stage plus a separate oxygen refill hook.",
                "reconciliation": "Runtime v3 uses the accepted open-surface rule, while preserving ship/moonpool banking as a separate offload hook.",
            },
            {
                "topic": "terrain topology",
                "runtime_blockout": "Historical blockout used separate wall masses and water lanes, which read as floating chunks in open water.",
                "accepted_surface_floor": "Uses continuous seafloor shelf segments with cave holes and named cave systems below.",
                "reconciliation": "Runtime v3 derives topology from source-PNG-traced playable_water_regions carved through one terrain_domain; generated solid_terrain entries are collision partitions only.",
            },
            {
                "topic": "interaction model",
                "runtime_blockout": "Historical blockout used resource pockets, cave-mouth affordances, and validation rules.",
                "accepted_surface_floor": "Uses explicit scene_hooks for oxygen, offload, cave entrances, hazards, gates, pickups, scans, and return currents.",
                "reconciliation": "Runtime v3 uses explicit scene_hooks and preserves relevant blockout defect-prevention validation rules.",
            },
            {
                "topic": "runtime wiring",
                "runtime_blockout": "Historical blockout contained visible_path, collision_path, and lip_path fields for hand-authored runtime builder nodes.",
                "accepted_surface_floor": "Contains visual/collision/rim strategies plus named scene hooks and object placement intent.",
                "reconciliation": "Runtime v3 generator creates terrain_domain visuals, playable-water cutouts, collision partitions, and Area2D hooks from accepted geometry.",
            },
        ],
        "recommended_next_artifact": {
            "path": "docs/planning/maps/area_01_runtime_source_map_v3.json",
            "purpose": "Single promoted source of truth that turns accepted playable-water geometry into deterministic runtime terrain, collision, hooks, and previews.",
            "should_include": [
                "continuous terrain_domain copied from source-map domain policy",
                "playable_water_regions generated from the source PNG trace and cave mouths",
                "solid_terrain collision partitions generated from terrain_domain minus playable_water_regions",
                "scene_hooks copied from accepted source geometry",
                "validation rules inherited from both current blockout and accepted geometry",
                "terrain kit manifest pointer",
                "explicit statement that sprites do not define collision",
            ],
        },
        "must_not_do": [
            "Do not wire the v3 preview PNG as a baked runtime map.",
            "Do not keep runtime collision on the old blockout while showing the accepted surface-floor terrain art.",
            "Do not hand-place visual walls or primary solid chunks that are not generated from the promoted source polygons.",
            "Do not infer cave-mouth blockers or routes from sprite pixels.",
        ],
        "source_reference_topology_rule": surface_reference["topology_rule"],
        "terrain_kit_status": terrain_kit_manifest["status"],
    }

    OUTPUT_PATH.write_text(json.dumps(comparison, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(OUTPUT_PATH)


if __name__ == "__main__":
    main()
