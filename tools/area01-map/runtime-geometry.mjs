import crypto from "node:crypto";
import {
  OPEN_SURFACE,
  cellCenter,
  connectedWaterComponents,
  hookRuntimeName,
  isPlayableCell,
  mergePlayableWaterCutoutCells,
  mergeSolidCells,
  polygonFromWorldRect,
  rectCellsFromHook,
  runtimeName,
  sourceGridWaterBoundarySegments,
  validateRectCells,
  worldRectFromCells,
} from "./grid-helpers.mjs";

export function buildRuntimeGeometry(source) {
  const components = connectedWaterComponents(source);
  const solidRects = mergeSolidCells(source);
  const cellSize = source.cell_size;
  const surfaceRows = source.rows.findIndex((row) => [...row].some((cell) => cell !== OPEN_SURFACE));
  const firstTerrainRow = surfaceRows < 0 ? source.height : surfaceRows;
  const waterCutoutRects = mergePlayableWaterCutoutCells(source, firstTerrainRow);
  const sourceGridWaterEdges = sourceGridWaterBoundarySegments(source);
  const terrainY = firstTerrainRow * cellSize;
  const stageBounds = [0, 0, source.width * cellSize, source.height * cellSize];
  const sourceHash = crypto.createHash("sha256").update(JSON.stringify(source)).digest("hex");

  const solidTerrain = solidRects.map((rect, index) => {
    const id = `generated_grid_solid_${String(index + 1).padStart(3, "0")}`;
    return {
      id,
      source_cells: rect,
      polygon: polygonFromWorldRect(worldRectFromCells(rect, cellSize)),
      blocks_player: true,
      generation_source: {
        algorithm: "source_grid_solid_cells_greedy_rect_partition",
        source: "data/maps/area_01_source_grid_v1.json",
        source_cells: rect,
      },
      runtime_generation: {
        visual_role: "generated_solid_partition",
        generated_from: "data/maps/area_01_source_grid_v1.json",
        sprites_define_collision: false,
        visible_polygon2d_name: runtimeName(id, "Terrain"),
        collision_static_body2d_name: "RuntimeSourceCollision",
        collision_polygon2d_name: runtimeName(id, "Collision"),
        rim_container_name: runtimeName(id, "Rims"),
        visual_points_source: "this polygon",
        collision_points_source: "this polygon",
        rim_points_source: "this polygon",
      },
    };
  });

  const playableWaterRegions = (source.required_regions ?? []).map((region) => {
    const worldRect = worldRectFromCells(region.rect_cells, cellSize);
    const component = components.find((candidate) => candidate.cells.some((cell) => (
      cell[0] === region.sample_cell[0] && cell[1] === region.sample_cell[1]
    )));
    return {
      id: region.id,
      kind: region.kind,
      status: region.kind === "locked_promise" ? "future_locked" : "current",
      carves_collision: true,
      source_rect_cells: region.rect_cells,
      source_sample_cell: region.sample_cell,
      source_component_id: component?.id ?? "",
      cell_count: validateRectCells(source, region.rect_cells, `region ${region.id}`, []).filter(([x, y]) => isPlayableCell(source, x, y)).length,
      polygon: polygonFromWorldRect(worldRect),
      runtime_generation: {
        visual_role: region.kind === "surface" ? "open_surface_water_reference" : "playable_water_reference",
        visible_polygon2d_name: runtimeName(region.id, "WaterCutout"),
        edge_line2d_name: runtimeName(region.id, "WaterEdge"),
        visual_points_source: "source grid playable water region",
        collision_carve_source: "source grid playable water cells",
      },
    };
  });

  const sceneHooks = (source.hooks ?? []).map((hook) => {
    const rectCells = rectCellsFromHook(hook);
    const worldRect = worldRectFromCells(rectCells, cellSize);
    return {
      id: hook.id,
      type: hook.type,
      resource: hook.resource,
      target: hook.target,
      source_cells: rectCells,
      world_rect: worldRect,
      world_position: Array.isArray(hook.cell) ? cellCenter(hook.cell, cellSize) : [worldRect[0] + worldRect[2] / 2, worldRect[1] + worldRect[3] / 2],
      points: polygonFromWorldRect(worldRect),
      runtime_generation: {
        area2d_name: hookRuntimeName(hook.id, "Area"),
        collision_polygon2d_name: hookRuntimeName(hook.id, "Trigger"),
        points_source: "this hook points",
        blocks_player: false,
      },
    };
  });

  const reviewPoints = (source.review_points ?? []).map((point) => ({
    id: point.id,
    source_cell: point.cell,
    world_position: cellCenter(point.cell, cellSize),
  }));

  const sourceGridWaterCutouts = waterCutoutRects.map((rect, index) => {
    const id = `generated_grid_water_cutout_${String(index + 1).padStart(3, "0")}`;
    return {
      id,
      source_cells: rect,
      polygon: polygonFromWorldRect(worldRectFromCells(rect, cellSize)),
      runtime_generation: {
        visual_role: "source_grid_water_cutout",
        generated_from: "data/maps/area_01_source_grid_v1.json",
        visible_polygon2d_name: runtimeName(id, "WaterCutout"),
        visual_points_source: "this polygon",
        sprites_define_collision: false,
      },
    };
  });

  return {
    schema_version: 1,
    map_id: "area_01_runtime_geometry_generated",
    generated: true,
    source: "data/maps/area_01_source_grid_v1.json",
    generated_from: "data/maps/area_01_source_grid_v1.json",
    generated_by: "tools/build-area01-map.mjs",
    source_sha256: sourceHash,
    cell_size: cellSize,
    stage_bounds: stageBounds,
    coordinate_space: {
      origin: "top_left",
      units: "pixels",
      cell_size: cellSize,
      width_cells: source.width,
      height_cells: source.height,
    },
    source_grid: {
      map_id: source.map_id,
      width: source.width,
      height: source.height,
      legend: source.legend,
    },
    terrain_domain: {
      id: "continuous_undersea_terrain_domain",
      polygon: polygonFromWorldRect([0, terrainY, source.width * cellSize, source.height * cellSize - terrainY]),
      runtime_generation: {
        visual_role: "terrain_domain_reference",
        player_facing: false,
        visible_polygon2d_name: "ContinuousUnderseaTerrainDomainGuide",
      },
    },
    playable_water_components: components.map((component) => ({
      id: component.id,
      cell_count: component.cell_count,
      bounds_cells: component.bounds_cells,
      world_bounds: worldRectFromCells(component.bounds_cells, cellSize),
      touches_surface: component.touches_surface,
    })),
    source_grid_water_cutouts: sourceGridWaterCutouts,
    source_grid_water_edges: sourceGridWaterEdges,
    playable_water_regions: playableWaterRegions,
    solid_terrain: solidTerrain,
    scene_hooks: sceneHooks,
    review_points: reviewPoints,
    camera_review_points: reviewPoints,
    validation_contract: {
      topology_source: "data/maps/area_01_source_grid_v1.json",
      generated_geometry_must_not_be_hand_edited: true,
      visible_collision_rim_rule: "visible terrain source == collision source == rim/lip source",
      screenshots_are_confirmation_only: true,
    },
  };
}
