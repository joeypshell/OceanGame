#!/usr/bin/env node
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const SOURCE_PATH = path.join(ROOT, "data", "maps", "area_01_source_grid_v1.json");
const RUNTIME_PATH = path.join(ROOT, "data", "maps", "area_01_runtime_geometry.generated.json");
const ARTIFACT_DIR = path.join(ROOT, "artifacts", "maps");
const SOURCE_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_source_grid_preview.svg");
const RUNTIME_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_runtime_geometry_preview.svg");
const DIFF_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_diff_overlay.svg");

const ALLOWED_CELLS = new Set(["#", ".", "~"]);
const SOLID = "#";
const OPEN_SURFACE = "~";

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function writeJson(filePath, value) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, `${JSON.stringify(value, null, 2)}\n`, "utf8");
}

function writeText(filePath, value) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, value, "utf8");
}

function fail(errors) {
  for (const error of errors) {
    console.error(`FAIL ${error}`);
  }
  process.exit(1);
}

function parseArgs(argv) {
  const args = new Set(argv.slice(2));
  return {
    validate: args.has("--validate") || args.size === 0,
    write: args.has("--write"),
    previews: args.has("--previews") || args.has("--write-previews"),
  };
}

function pascalCase(value) {
  return String(value)
    .split("_")
    .filter(Boolean)
    .map((part) => `${part.slice(0, 1).toUpperCase()}${part.slice(1)}`)
    .join("");
}

function cellKey(x, y) {
  return `${x},${y}`;
}

function worldRectFromCells(rectCells, cellSize) {
  const [x, y, width, height] = rectCells;
  return [x * cellSize, y * cellSize, width * cellSize, height * cellSize];
}

function polygonFromWorldRect([x, y, width, height]) {
  return [
    [x, y],
    [x + width, y],
    [x + width, y + height],
    [x, y + height],
  ];
}

function rectCellsFromHook(hook) {
  if (Array.isArray(hook.rect_cells)) {
    return hook.rect_cells;
  }
  if (Array.isArray(hook.cell)) {
    return [hook.cell[0], hook.cell[1], 1, 1];
  }
  return null;
}

function cellCenter(cell, cellSize) {
  return [(cell[0] + 0.5) * cellSize, (cell[1] + 0.5) * cellSize];
}

function validateSourceGrid(source) {
  const errors = [];
  if (source.schema_version !== 1) {
    errors.push("source grid schema_version must be 1");
  }
  if (source.map_id !== "area_01") {
    errors.push("source grid map_id must be area_01");
  }
  if (!Number.isInteger(source.cell_size) || source.cell_size <= 0) {
    errors.push("source grid cell_size must be a positive integer");
  }
  if (!Number.isInteger(source.width) || source.width <= 0) {
    errors.push("source grid width must be a positive integer");
  }
  if (!Number.isInteger(source.height) || source.height <= 0) {
    errors.push("source grid height must be a positive integer");
  }
  if (!Array.isArray(source.rows) || source.rows.length !== source.height) {
    errors.push("source grid rows length must match height");
    return errors;
  }

  source.rows.forEach((row, y) => {
    if (typeof row !== "string") {
      errors.push(`row ${y} must be a string`);
      return;
    }
    if (row.length !== source.width) {
      errors.push(`row ${y} width ${row.length} does not match ${source.width}`);
    }
    [...row].forEach((cell, x) => {
      if (!ALLOWED_CELLS.has(cell)) {
        errors.push(`unknown grid cell '${cell}' at ${x},${y}`);
      }
    });
  });

  const surfaceRows = source.rows.filter((row) => [...row].every((cell) => cell === OPEN_SURFACE)).length;
  if (surfaceRows < 3) {
    errors.push("open surface band must be at least 3 full-width rows");
  }
  for (let y = 0; y < surfaceRows; y += 1) {
    if (![...source.rows[y]].every((cell) => cell === OPEN_SURFACE)) {
      errors.push(`surface row ${y} must be full-width open surface water`);
    }
  }
  if (!source.hooks?.some((hook) => hook.id === "oxygen_surface" && hook.type === "oxygen")) {
    errors.push("oxygen_surface hook is required");
  }
  if (!source.hooks?.some((hook) => hook.id === "ship_offload" && hook.type === "offload")) {
    errors.push("ship_offload hook is required");
  }
  if (!source.hooks?.some((hook) => hook.type === "player_start")) {
    errors.push("player_start hook is required");
  }
  return errors;
}

function isInsideGrid(source, x, y) {
  return x >= 0 && y >= 0 && x < source.width && y < source.height;
}

function gridCell(source, x, y) {
  if (!isInsideGrid(source, x, y)) {
    return null;
  }
  return source.rows[y][x];
}

function isPlayableCell(source, x, y) {
  const cell = gridCell(source, x, y);
  return cell === "." || cell === "~";
}

function validateRectCells(source, rectCells, label, errors) {
  if (!Array.isArray(rectCells) || rectCells.length !== 4) {
    errors.push(`${label} must have rect_cells [x,y,width,height]`);
    return [];
  }
  const [x0, y0, width, height] = rectCells;
  if (![x0, y0, width, height].every(Number.isInteger) || width <= 0 || height <= 0) {
    errors.push(`${label} rect_cells must be positive integer dimensions`);
    return [];
  }
  const cells = [];
  for (let y = y0; y < y0 + height; y += 1) {
    for (let x = x0; x < x0 + width; x += 1) {
      if (!isInsideGrid(source, x, y)) {
        errors.push(`${label} references out-of-grid cell ${x},${y}`);
      } else {
        cells.push([x, y]);
      }
    }
  }
  return cells;
}

function validateTopology(source, components) {
  const errors = [];
  const componentByCell = new Map();
  for (const component of components) {
    for (const cell of component.cells) {
      componentByCell.set(cellKey(cell[0], cell[1]), component.id);
    }
  }
  const surfaceComponent = components.find((component) => component.touches_surface);

  for (const region of source.required_regions ?? []) {
    if (!region.required) {
      continue;
    }
    if (!Array.isArray(region.sample_cell) || region.sample_cell.length !== 2) {
      errors.push(`required region ${region.id} must define sample_cell`);
      continue;
    }
    const [x, y] = region.sample_cell;
    if (!isPlayableCell(source, x, y)) {
      errors.push(`required region ${region.id} sample_cell ${x},${y} is not playable water`);
    }
    const cells = validateRectCells(source, region.rect_cells, `required region ${region.id}`, errors);
    const waterCells = cells.filter(([cx, cy]) => isPlayableCell(source, cx, cy));
    if (waterCells.length < Number(region.min_water_cells ?? 1)) {
      errors.push(`required region ${region.id} has ${waterCells.length} water cells, below ${region.min_water_cells}`);
    }
    if (surfaceComponent != null && componentByCell.get(cellKey(x, y)) !== surfaceComponent.id) {
      errors.push(`required region ${region.id} is not connected to open surface water`);
    }
  }

  for (const hook of source.hooks ?? []) {
    const rectCells = rectCellsFromHook(hook);
    const cells = validateRectCells(source, rectCells, `hook ${hook.id}`, errors);
    for (const [x, y] of cells) {
      if (!isPlayableCell(source, x, y)) {
        errors.push(`hook ${hook.id} overlaps solid terrain at ${x},${y}`);
      }
    }
    if ((hook.type === "pickup" || hook.type === "scan") && !Array.isArray(hook.cell)) {
      errors.push(`hook ${hook.id} must use a single playable cell`);
    }
  }

  for (const point of source.review_points ?? []) {
    if (!Array.isArray(point.cell) || point.cell.length !== 2) {
      errors.push(`review point ${point.id} must define cell`);
      continue;
    }
    const [x, y] = point.cell;
    if (!isPlayableCell(source, x, y)) {
      errors.push(`review point ${point.id} is inside solid terrain at ${x},${y}`);
    }
  }
  return errors;
}

function connectedWaterComponents(source) {
  const visited = new Set();
  const components = [];
  const directions = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
  ];
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      if (!isPlayableCell(source, x, y) || visited.has(cellKey(x, y))) {
        continue;
      }
      const queue = [[x, y]];
      const cells = [];
      visited.add(cellKey(x, y));
      while (queue.length > 0) {
        const [cx, cy] = queue.shift();
        cells.push([cx, cy]);
        for (const [dx, dy] of directions) {
          const nx = cx + dx;
          const ny = cy + dy;
          const key = cellKey(nx, ny);
          if (!visited.has(key) && isPlayableCell(source, nx, ny)) {
            visited.add(key);
            queue.push([nx, ny]);
          }
        }
      }
      const xs = cells.map((cell) => cell[0]);
      const ys = cells.map((cell) => cell[1]);
      components.push({
        id: `water_component_${String(components.length + 1).padStart(3, "0")}`,
        cells,
        cell_count: cells.length,
        bounds_cells: [
          Math.min(...xs),
          Math.min(...ys),
          Math.max(...xs) - Math.min(...xs) + 1,
          Math.max(...ys) - Math.min(...ys) + 1,
        ],
        touches_surface: cells.some((cell) => gridCell(source, cell[0], cell[1]) === OPEN_SURFACE),
      });
    }
  }
  return components;
}

function mergeGridCells(source, shouldMergeCell) {
  const visited = Array.from({ length: source.height }, () => Array(source.width).fill(false));
  const rects = [];
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      if (visited[y][x] || !shouldMergeCell(x, y)) {
        continue;
      }
      let width = 0;
      while (x + width < source.width && !visited[y][x + width] && shouldMergeCell(x + width, y)) {
        width += 1;
      }
      let height = 1;
      let canExtend = true;
      while (y + height < source.height && canExtend) {
        for (let tx = x; tx < x + width; tx += 1) {
          if (visited[y + height][tx] || !shouldMergeCell(tx, y + height)) {
            canExtend = false;
            break;
          }
        }
        if (canExtend) {
          height += 1;
        }
      }
      for (let ty = y; ty < y + height; ty += 1) {
        for (let tx = x; tx < x + width; tx += 1) {
          visited[ty][tx] = true;
        }
      }
      rects.push([x, y, width, height]);
    }
  }
  return rects;
}

function mergeSolidCells(source) {
  return mergeGridCells(source, (x, y) => gridCell(source, x, y) === SOLID);
}

function mergePlayableWaterCutoutCells(source, firstTerrainRow) {
  return mergeGridCells(source, (x, y) => y >= firstTerrainRow && isPlayableCell(source, x, y));
}

function sourceGridWaterBoundarySegments(source) {
  const rangesByKey = new Map();
  const addRange = (orientation, solidSide, line, start, end, trimType) => {
    const key = `${orientation}:${solidSide}:${line}:${trimType}`;
    if (!rangesByKey.has(key)) {
      rangesByKey.set(key, { orientation, solidSide, line, trimType, ranges: [] });
    }
    rangesByKey.get(key).ranges.push([start, end]);
  };

  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      if (!isPlayableCell(source, x, y)) {
        continue;
      }

      if (y > 0 && gridCell(source, x, y - 1) === SOLID) {
        addRange("horizontal", "top", y, x, x + 1, "underside");
      }
      if (y + 1 < source.height && gridCell(source, x, y + 1) === SOLID) {
        addRange("horizontal", "bottom", y + 1, x, x + 1, (y + 1) * source.cell_size >= 1400 ? "deep_floor_lip" : "top_lip");
      }
      if (x > 0 && gridCell(source, x - 1, y) === SOLID) {
        addRange("vertical", "left", x, y, y + 1, "vertical_wall");
      }
      if (x + 1 < source.width && gridCell(source, x + 1, y) === SOLID) {
        addRange("vertical", "right", x + 1, y, y + 1, "vertical_wall");
      }
    }
  }

  const segments = [];
  for (const entry of rangesByKey.values()) {
    const ranges = entry.ranges.sort((a, b) => a[0] - b[0]);
    let current = null;
    for (const range of ranges) {
      if (current == null) {
        current = [...range];
        continue;
      }
      if (range[0] <= current[1]) {
        current[1] = Math.max(current[1], range[1]);
        continue;
      }
      segments.push({ ...entry, range: current });
      current = [...range];
    }
    if (current != null) {
      segments.push({ ...entry, range: current });
    }
  }

  return segments.map((segment, index) => {
    const id = `generated_grid_water_edge_${String(index + 1).padStart(3, "0")}`;
    const line = segment.line * source.cell_size;
    const start = segment.range[0] * source.cell_size;
    const end = segment.range[1] * source.cell_size;
    const points = segment.orientation === "horizontal" ? [[start, line], [end, line]] : [[line, start], [line, end]];
    return {
      id,
      source_line: segment.line,
      source_range: segment.range,
      orientation: segment.orientation,
      solid_side: segment.solidSide,
      trim_type: segment.trimType,
      points,
      runtime_generation: {
        visual_role: "source_grid_water_boundary_edge",
        generated_from: "data/maps/area_01_source_grid_v1.json",
        sprites_define_collision: false,
      },
    };
  });
}

function rasterizeSolidRects(source, rects) {
  const raster = Array.from({ length: source.height }, () => Array(source.width).fill(false));
  for (const [x0, y0, width, height] of rects) {
    for (let y = y0; y < y0 + height; y += 1) {
      for (let x = x0; x < x0 + width; x += 1) {
        raster[y][x] = true;
      }
    }
  }
  return raster;
}

function validateGeneratedCoverage(source, solidRects) {
  const errors = [];
  const raster = rasterizeSolidRects(source, solidRects);
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      const expected = gridCell(source, x, y) === SOLID;
      if (raster[y][x] !== expected) {
        errors.push(`generated terrain coverage mismatch at ${x},${y}`);
      }
    }
  }
  return errors;
}

function runtimeName(id, suffix) {
  return `${pascalCase(id)}${suffix}`;
}

function hookRuntimeName(id, suffix) {
  const overrides = {
    oxygen_surface: {
      Area: "SurfaceOxygenRefillZoneArea",
      Trigger: "SurfaceOxygenRefillZoneTrigger",
    },
    ship_offload: {
      Area: "ShipOffloadZoneArea",
      Trigger: "ShipOffloadZoneTrigger",
    },
  };
  return overrides[id]?.[suffix] ?? runtimeName(id, suffix);
}

function buildRuntimeGeometry(source) {
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

function colorForCell(cell) {
  if (cell === SOLID) {
    return "#6d7677";
  }
  if (cell === OPEN_SURFACE) {
    return "#6eddf2";
  }
  return "#f6fbff";
}

function hookColor(type) {
  return {
    oxygen: "#00d9ff",
    offload: "#ff9900",
    player_start: "#ffe04a",
    pickup: "#25c48c",
    scan: "#4fa3ff",
    gate: "#ff4559",
    return_current: "#a26cff",
    hazard: "#ffcc33",
  }[type] ?? "#ffffff";
}

function svgHeader(source, title) {
  const scale = 10;
  const width = source.width * scale;
  const height = source.height * scale;
  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${source.width} ${source.height}">`,
    `<rect x="0" y="0" width="${source.width}" height="${source.height}" fill="#d6f3ff"/>`,
    `<text x="1" y="2" font-family="monospace" font-size="1.2" fill="#0b2c38">${title}</text>`,
  ];
}

function drawHooksAndReviewPoints(source, lines) {
  for (const hook of source.hooks ?? []) {
    const rect = rectCellsFromHook(hook);
    const [x, y, width, height] = rect;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="${hookColor(hook.type)}" opacity="0.82" stroke="#06191f" stroke-width="0.08"/>`);
    lines.push(`<text x="${x + 0.1}" y="${y + 0.7}" font-family="monospace" font-size="0.72" fill="#06191f">${hook.id}</text>`);
  }
  for (const point of source.review_points ?? []) {
    const [x, y] = point.cell;
    lines.push(`<circle cx="${x + 0.5}" cy="${y + 0.5}" r="0.28" fill="#111111" opacity="0.75"/>`);
  }
}

function sourcePreviewSvg(source) {
  const lines = svgHeader(source, "Area 01 source grid");
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      lines.push(`<rect x="${x}" y="${y}" width="1" height="1" fill="${colorForCell(gridCell(source, x, y))}" stroke="#12343d" stroke-width="0.02"/>`);
    }
  }
  drawHooksAndReviewPoints(source, lines);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}

function runtimePreviewSvg(source, runtime) {
  const lines = svgHeader(source, "Area 01 generated runtime geometry");
  lines.push(`<rect x="0" y="0" width="${source.width}" height="${source.height}" fill="#6eddf2" opacity="0.4"/>`);
  for (const terrain of runtime.solid_terrain) {
    const [x, y, width, height] = terrain.source_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="#526264" opacity="0.88" stroke="#0a2027" stroke-width="0.06"/>`);
  }
  for (const cutout of runtime.source_grid_water_cutouts ?? []) {
    const [x, y, width, height] = cutout.source_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="#d8f6ff" opacity="0.56" stroke="#00c9ff" stroke-width="0.035"/>`);
  }
  for (const region of runtime.playable_water_regions) {
    const [x, y, width, height] = region.source_rect_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="none" opacity="0.4" stroke="#00c9ff" stroke-width="0.1" stroke-dasharray="0.45 0.22"/>`);
  }
  for (const edge of runtime.source_grid_water_edges ?? []) {
    const [start, finish] = edge.points;
    lines.push(`<line x1="${start[0] / source.cell_size}" y1="${start[1] / source.cell_size}" x2="${finish[0] / source.cell_size}" y2="${finish[1] / source.cell_size}" stroke="#06262d" stroke-width="0.08" opacity="0.48"/>`);
  }
  drawHooksAndReviewPoints(source, lines);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}

function diffPreviewSvg(source, runtime) {
  const lines = svgHeader(source, "Area 01 source/runtime diff");
  const solidRects = runtime.solid_terrain.map((terrain) => terrain.source_cells);
  const raster = rasterizeSolidRects(source, solidRects);
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      const expected = gridCell(source, x, y) === SOLID;
      const actual = raster[y][x];
      let fill = "#f6fbff";
      if (expected && actual) {
        fill = "#657174";
      } else if (expected && !actual) {
        fill = "#ff3b30";
      } else if (!expected && actual) {
        fill = "#ffcc00";
      } else if (gridCell(source, x, y) === OPEN_SURFACE) {
        fill = "#6eddf2";
      }
      lines.push(`<rect x="${x}" y="${y}" width="1" height="1" fill="${fill}" stroke="#12343d" stroke-width="0.02"/>`);
    }
  }
  lines.push(`<text x="1" y="${source.height - 1}" font-family="monospace" font-size="1" fill="#0b2c38">red=missing solid yellow=extra solid gray=matched solid</text>`);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}

function main() {
  const options = parseArgs(process.argv);
  const source = readJson(SOURCE_PATH);
  let errors = validateSourceGrid(source);
  const components = connectedWaterComponents(source);
  errors = errors.concat(validateTopology(source, components));
  const runtime = buildRuntimeGeometry(source);
  errors = errors.concat(validateGeneratedCoverage(source, runtime.solid_terrain.map((terrain) => terrain.source_cells)));
  if (errors.length > 0) {
    fail(errors);
  }

  if (options.write) {
    writeJson(RUNTIME_PATH, runtime);
    console.log(`wrote ${path.relative(ROOT, RUNTIME_PATH)}`);
  }
  if (options.previews) {
    writeText(SOURCE_PREVIEW_PATH, sourcePreviewSvg(source));
    writeText(RUNTIME_PREVIEW_PATH, runtimePreviewSvg(source, runtime));
    writeText(DIFF_PREVIEW_PATH, diffPreviewSvg(source, runtime));
    console.log(`wrote ${path.relative(ROOT, SOURCE_PREVIEW_PATH)}`);
    console.log(`wrote ${path.relative(ROOT, RUNTIME_PREVIEW_PATH)}`);
    console.log(`wrote ${path.relative(ROOT, DIFF_PREVIEW_PATH)}`);
  }
  if (options.validate) {
    console.log(`PASS Area 01 source-grid map validation: ${source.width}x${source.height}, ${runtime.solid_terrain.length} generated solid partitions, ${runtime.playable_water_regions.length} playable regions, ${runtime.scene_hooks.length} hooks, ${runtime.review_points.length} review points.`);
  }
}

main();
