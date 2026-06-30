import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const sourceGridPath = path.join(repoRoot, "data", "maps", "area_01_source_grid_v1.json");
const runtimePath = path.join(repoRoot, "data", "maps", "area_01_runtime_geometry.generated.json");

function fail(message) {
  throw new Error(`Area 01 generated runtime geometry validation failed: ${message}`);
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function hashSource(source) {
  return crypto.createHash("sha256").update(JSON.stringify(source)).digest("hex");
}

function assertArray(value, message) {
  if (!Array.isArray(value)) {
    fail(message);
  }
}

function isPoint(value) {
  return Array.isArray(value) && value.length === 2 && value.every(Number.isFinite);
}

function isPlayable(source, x, y) {
  const cell = source.rows?.[y]?.[x];
  return cell === "." || cell === "~";
}

function rasterizeSolids(source, runtime) {
  const raster = Array.from({ length: source.height }, () => Array(source.width).fill(false));
  for (const terrain of runtime.solid_terrain) {
    const cells = terrain.source_cells;
    if (!Array.isArray(cells) || cells.length !== 4) {
      fail(`${terrain.id ?? "solid terrain"} must preserve source_cells [x,y,width,height]`);
    }
    const [x0, y0, width, height] = cells;
    if (![x0, y0, width, height].every(Number.isInteger) || width <= 0 || height <= 0) {
      fail(`${terrain.id} source_cells must use positive integer dimensions`);
    }
    for (let y = y0; y < y0 + height; y += 1) {
      for (let x = x0; x < x0 + width; x += 1) {
        if (!raster[y] || raster[y][x] === undefined) {
          fail(`${terrain.id} source_cells extends outside the source grid`);
        }
        raster[y][x] = true;
      }
    }
  }
  return raster;
}

function rectCellsForHook(hook) {
  return hook.source_cells ?? null;
}

function cellsFromRect(rect) {
  const [x0, y0, width, height] = rect;
  const cells = [];
  for (let y = y0; y < y0 + height; y += 1) {
    for (let x = x0; x < x0 + width; x += 1) {
      cells.push([x, y]);
    }
  }
  return cells;
}

const source = readJson(sourceGridPath);
const runtime = readJson(runtimePath);

if (source.map_id !== "area_01") {
  fail(`unexpected source grid map_id ${source.map_id}`);
}
if (runtime.map_id !== "area_01_runtime_geometry_generated") {
  fail(`unexpected runtime map_id ${runtime.map_id}`);
}
if (runtime.generated !== true) {
  fail("runtime geometry must be marked generated");
}
if (runtime.generated_from !== "data/maps/area_01_source_grid_v1.json") {
  fail("runtime geometry must name the source grid");
}
if (runtime.generated_by !== "tools/build-area01-map.mjs") {
  fail("runtime geometry must name tools/build-area01-map.mjs");
}
if (runtime.source_sha256 !== hashSource(source)) {
  fail("runtime geometry is stale; regenerate it from the source grid");
}
if (runtime.validation_contract?.generated_geometry_must_not_be_hand_edited !== true) {
  fail("runtime validation contract must forbid hand-editing generated geometry");
}
if (runtime.validation_contract?.screenshots_are_confirmation_only !== true) {
  fail("runtime validation contract must keep screenshots as confirmation only");
}

assertArray(source.rows, "source grid rows must be an array");
assertArray(runtime.solid_terrain, "solid_terrain must be an array");
assertArray(runtime.playable_water_regions, "playable_water_regions must be an array");
assertArray(runtime.scene_hooks, "scene_hooks must be an array");
assertArray(runtime.review_points, "review_points must be an array");

const raster = rasterizeSolids(source, runtime);
for (let y = 0; y < source.height; y += 1) {
  for (let x = 0; x < source.width; x += 1) {
    const expectedSolid = source.rows[y][x] === "#";
    if (raster[y][x] !== expectedSolid) {
      fail(`generated solid terrain does not match source grid at ${x},${y}`);
    }
  }
}

const requiredRegionIds = new Set([
  "open_surface_water",
  "starter_kelp_hole",
  "shell_reef_route",
  "thermal_vent_pocket",
  "blue_chimney_route",
  "pressure_wreck_branch",
  "future_deep_exit",
]);
const waterIds = new Set();
for (const water of runtime.playable_water_regions) {
  waterIds.add(water.id);
  assertArray(water.polygon, `${water.id} polygon must be an array`);
  if (water.polygon.length < 3 || !water.polygon.every(isPoint)) {
    fail(`${water.id} polygon must contain numeric points`);
  }
  if (!Array.isArray(water.source_rect_cells)) {
    fail(`${water.id} must preserve source_rect_cells`);
  }
}
for (const id of requiredRegionIds) {
  if (!waterIds.has(id)) {
    fail(`missing required playable-water region ${id}`);
  }
}

for (const terrain of runtime.solid_terrain) {
  assertArray(terrain.polygon, `${terrain.id} polygon must be an array`);
  if (terrain.polygon.length < 3 || !terrain.polygon.every(isPoint)) {
    fail(`${terrain.id} polygon must contain numeric points`);
  }
  if (terrain.runtime_generation?.visual_role !== "generated_solid_partition") {
    fail(`${terrain.id} must be generated_solid_partition`);
  }
  if (terrain.runtime_generation?.visual_points_source !== "this polygon") {
    fail(`${terrain.id} visual points must use this polygon`);
  }
  if (terrain.runtime_generation?.collision_points_source !== "this polygon") {
    fail(`${terrain.id} collision points must use this polygon`);
  }
  if (terrain.runtime_generation?.rim_points_source !== "this polygon") {
    fail(`${terrain.id} rim points must use this polygon`);
  }
  if (terrain.runtime_generation?.sprites_define_collision !== false) {
    fail(`${terrain.id} sprites must not define collision`);
  }
}

const requiredHookIds = new Set([
  "oxygen_surface",
  "ship_offload",
  "player_start",
  "starter_kelp_fiber",
  "starter_shell_fragments",
  "starter_food_supply",
]);
const hooksById = new Map(runtime.scene_hooks.map((hook) => [hook.id, hook]));
for (const id of requiredHookIds) {
  if (!hooksById.has(id)) {
    fail(`missing required scene hook ${id}`);
  }
}
for (const hook of runtime.scene_hooks) {
  assertArray(hook.points, `${hook.id} points must be an array`);
  if (hook.points.length < 3 || !hook.points.every(isPoint)) {
    fail(`${hook.id} points must contain numeric points`);
  }
  const cells = rectCellsForHook(hook);
  if (!Array.isArray(cells)) {
    fail(`${hook.id} must preserve source_cells`);
  }
  for (const [x, y] of cellsFromRect(cells)) {
    if (!isPlayable(source, x, y)) {
      fail(`${hook.id} overlaps solid terrain at source cell ${x},${y}`);
    }
  }
  if (!hook.runtime_generation?.area2d_name || !hook.runtime_generation?.collision_polygon2d_name) {
    fail(`${hook.id} must name generated Godot hook nodes`);
  }
  if (hook.runtime_generation?.blocks_player !== false) {
    fail(`${hook.id} must not own blocking collision`);
  }
}

for (const point of runtime.review_points) {
  if (!Array.isArray(point.source_cell) || point.source_cell.length !== 2) {
    fail(`${point.id ?? "review point"} must preserve source_cell`);
  }
  if (!isPlayable(source, point.source_cell[0], point.source_cell[1])) {
    fail(`${point.id} review point is inside solid terrain`);
  }
}

console.log(
  `PASS Area 01 generated runtime geometry validation: ${runtime.solid_terrain.length} solid partitions, ${runtime.playable_water_regions.length} playable regions, ${runtime.scene_hooks.length} hooks, ${runtime.review_points.length} review points.`,
);
