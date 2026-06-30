import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const sourceGridPath = path.join(repoRoot, "data", "maps", "area_01_source_grid_v1.json");
const runtimePath = path.join(repoRoot, "data", "maps", "area_01_runtime_geometry.generated.json");

const REQUIRED_REVIEW_POINT_IDS = new Set([
  "surface_entry",
  "starter_kelp_hole",
  "shell_reef_route",
  "central_drop_thermal_vent",
  "blue_chimney_route",
  "pressure_wreck_branch",
  "future_deep_exit",
]);

function fail(message) {
  throw new Error(`Area 01 generated review-point validation failed: ${message}`);
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function isPlayable(source, x, y) {
  const cell = source.rows?.[y]?.[x];
  return cell === "." || cell === "~";
}

function isSolid(source, x, y) {
  return source.rows?.[y]?.[x] === "#";
}

function solidCellsNear(source, centerCell, radius) {
  let count = 0;
  const [centerX, centerY] = centerCell;
  for (let y = centerY - radius; y <= centerY + radius; y += 1) {
    for (let x = centerX - radius; x <= centerX + radius; x += 1) {
      if (isSolid(source, x, y)) {
        count += 1;
      }
    }
  }
  return count;
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

const source = readJson(sourceGridPath);
const runtime = readJson(runtimePath);

if (runtime.map_id !== "area_01_runtime_geometry_generated") {
  fail(`unexpected map_id ${runtime.map_id}`);
}
if (!Array.isArray(runtime.review_points) || runtime.review_points.length === 0) {
  fail("review_points must be generated from the source grid");
}

const reviewIds = new Set();
for (const point of runtime.review_points) {
  reviewIds.add(point.id);
  if (!Array.isArray(point.source_cell) || point.source_cell.length !== 2) {
    fail(`${point.id} must preserve source_cell`);
  }
  if (!Array.isArray(point.world_position) || point.world_position.length !== 2) {
    fail(`${point.id} must preserve world_position`);
  }
  if (!isPlayable(source, point.source_cell[0], point.source_cell[1])) {
    fail(`${point.id} is inside solid terrain at source cell ${point.source_cell.join(",")}`);
  }
  if (point.id !== "surface_entry" && solidCellsNear(source, point.source_cell, 5) < 8) {
    fail(`${point.id} does not have enough nearby solid terrain to frame a cave/pocket review`);
  }
  for (const solid of runtime.solid_terrain) {
    if (pointInPolygon(point.world_position, solid.polygon)) {
      fail(`${point.id} world position is inside generated solid terrain ${solid.id}`);
    }
  }
}

for (const id of REQUIRED_REVIEW_POINT_IDS) {
  if (!reviewIds.has(id)) {
    fail(`missing generated review point ${id}`);
  }
}

console.log(
  `PASS Area 01 generated review-point validation: ${runtime.review_points.length} review points are in playable water and cave points are framed by nearby solid terrain.`,
);
