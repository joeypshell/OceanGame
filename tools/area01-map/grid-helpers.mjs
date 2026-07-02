export const ALLOWED_CELLS = new Set(["#", ".", "~"]);

export const SOLID = "#";

export const OPEN_SURFACE = "~";



export function pascalCase(value) {
  return String(value)
    .split("_")
    .filter(Boolean)
    .map((part) => `${part.slice(0, 1).toUpperCase()}${part.slice(1)}`)
    .join("");
}

export function cellKey(x, y) {
  return `${x},${y}`;
}

export function worldRectFromCells(rectCells, cellSize) {
  const [x, y, width, height] = rectCells;
  return [x * cellSize, y * cellSize, width * cellSize, height * cellSize];
}

export function polygonFromWorldRect([x, y, width, height]) {
  return [
    [x, y],
    [x + width, y],
    [x + width, y + height],
    [x, y + height],
  ];
}

export function rectCellsFromHook(hook) {
  if (Array.isArray(hook.rect_cells)) {
    return hook.rect_cells;
  }
  if (Array.isArray(hook.cell)) {
    return [hook.cell[0], hook.cell[1], 1, 1];
  }
  return null;
}

export function cellCenter(cell, cellSize) {
  return [(cell[0] + 0.5) * cellSize, (cell[1] + 0.5) * cellSize];
}

export function validateSourceGrid(source) {
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

export function isInsideGrid(source, x, y) {
  return x >= 0 && y >= 0 && x < source.width && y < source.height;
}

export function gridCell(source, x, y) {
  if (!isInsideGrid(source, x, y)) {
    return null;
  }
  return source.rows[y][x];
}

export function isPlayableCell(source, x, y) {
  const cell = gridCell(source, x, y);
  return cell === "." || cell === "~";
}

export function validateRectCells(source, rectCells, label, errors) {
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

export function validateTopology(source, components) {
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

export function connectedWaterComponents(source) {
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

export function mergeGridCells(source, shouldMergeCell) {
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

export function mergeSolidCells(source) {
  return mergeGridCells(source, (x, y) => gridCell(source, x, y) === SOLID);
}

export function mergePlayableWaterCutoutCells(source, firstTerrainRow) {
  return mergeGridCells(source, (x, y) => y >= firstTerrainRow && isPlayableCell(source, x, y));
}

export function sourceGridWaterBoundarySegments(source) {
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

export function rasterizeSolidRects(source, rects) {
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

export function validateGeneratedCoverage(source, solidRects) {
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

export function runtimeName(id, suffix) {
  return `${pascalCase(id)}${suffix}`;
}

export function hookRuntimeName(id, suffix) {
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
