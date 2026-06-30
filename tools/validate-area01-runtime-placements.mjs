import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const sourceGridPath = path.join(repoRoot, "data", "maps", "area_01_source_grid_v1.json");
const runtimePath = path.join(repoRoot, "data", "maps", "area_01_runtime_geometry.generated.json");

function fail(message) {
  throw new Error(`Area 01 generated hook placement validation failed: ${message}`);
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function rectCellsFromHook(hook) {
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

function gridCell(source, x, y) {
  return source.rows?.[y]?.[x] ?? "";
}

function isPlayable(source, x, y) {
  const cell = gridCell(source, x, y);
  return cell === "." || cell === "~";
}

function pointInPolygon(point, polygon) {
  let inside = false;
  for (let index = 0, previous = polygon.length - 1; index < polygon.length; previous = index++) {
    const currentPoint = polygon[index];
    const previousPoint = polygon[previous];
    const intersects =
      currentPoint[1] > point[1] !== previousPoint[1] > point[1] &&
      point[0] < ((previousPoint[0] - currentPoint[0]) * (point[1] - currentPoint[1])) /
        (previousPoint[1] - currentPoint[1]) + currentPoint[0];
    if (intersects) {
      inside = !inside;
    }
  }
  return inside;
}

function polygonCenter(polygon) {
  const total = polygon.reduce((acc, point) => [acc[0] + point[0], acc[1] + point[1]], [0, 0]);
  return [total[0] / polygon.length, total[1] / polygon.length];
}

const source = readJson(sourceGridPath);
const runtime = readJson(runtimePath);

if (runtime.map_id !== "area_01_runtime_geometry_generated") {
  fail(`unexpected map_id ${runtime.map_id}`);
}

const solids = runtime.solid_terrain.filter((solid) => solid.blocks_player !== false);
const requiredResourceHooks = new Set([
  "starter_kelp_fiber",
  "starter_shell_fragments",
  "starter_food_supply",
]);
const requiredSystemHooks = new Set([
  "oxygen_surface",
  "ship_offload",
  "player_start",
]);
const hookIds = new Set();

for (const hook of runtime.scene_hooks ?? []) {
  hookIds.add(hook.id);
  const rect = rectCellsFromHook(hook);
  if (!Array.isArray(rect) || rect.length !== 4) {
    fail(`${hook.id} must preserve source_cells [x,y,width,height]`);
  }
  for (const [x, y] of cellsFromRect(rect)) {
    if (!isPlayable(source, x, y)) {
      fail(`${hook.id} overlaps solid terrain at source cell ${x},${y}`);
    }
  }
  const center = polygonCenter(hook.points ?? []);
  for (const solid of solids) {
    if (pointInPolygon(center, solid.polygon)) {
      fail(`${hook.id} hook center is inside generated solid terrain ${solid.id}`);
    }
  }
  if (!hook.runtime_generation?.area2d_name || !hook.runtime_generation?.collision_polygon2d_name) {
    fail(`${hook.id} must name generated Godot hook nodes`);
  }
  if (hook.runtime_generation?.blocks_player !== false) {
    fail(`${hook.id} hook must not create blocking terrain collision`);
  }
}

for (const id of requiredResourceHooks) {
  if (!hookIds.has(id)) {
    fail(`missing starter resource hook ${id}`);
  }
}
for (const id of requiredSystemHooks) {
  if (!hookIds.has(id)) {
    fail(`missing system hook ${id}`);
  }
}

console.log(
  `PASS Area 01 generated hook placement validation: ${runtime.scene_hooks.length} hooks are in playable source-grid water and outside generated solid terrain.`,
);
