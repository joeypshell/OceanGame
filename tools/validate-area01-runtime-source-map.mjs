import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const sourceMapPath = path.join(
  repoRoot,
  "docs",
  "planning",
  "maps",
  "area_01_runtime_source_map_v2.json",
);

const allowedTrimTypes = new Set([
  "top_lip",
  "underside",
  "vertical_wall",
  "diagonal_slope",
  "deep_floor_lip",
]);

const MAX_EDGE_DISTANCE = 1.0;

function fail(message) {
  throw new Error(`Area 01 runtime source map validation failed: ${message}`);
}

function assertArray(value, message) {
  if (!Array.isArray(value)) {
    fail(message);
  }
}

function isPoint(value) {
  return (
    Array.isArray(value) &&
    value.length === 2 &&
    Number.isFinite(value[0]) &&
    Number.isFinite(value[1])
  );
}

function distancePointToSegment(point, start, end) {
  const segmentX = end[0] - start[0];
  const segmentY = end[1] - start[1];
  const segmentLengthSquared = segmentX * segmentX + segmentY * segmentY;
  if (segmentLengthSquared === 0) {
    return Math.hypot(point[0] - start[0], point[1] - start[1]);
  }

  const projected =
    ((point[0] - start[0]) * segmentX + (point[1] - start[1]) * segmentY) /
    segmentLengthSquared;
  const clamped = Math.max(0, Math.min(1, projected));
  const closest = [
    start[0] + clamped * segmentX,
    start[1] + clamped * segmentY,
  ];
  return Math.hypot(point[0] - closest[0], point[1] - closest[1]);
}

function distancePointToPolygonEdge(point, polygon) {
  let best = Infinity;
  for (let index = 0; index < polygon.length; index += 1) {
    const start = polygon[index];
    const end = polygon[(index + 1) % polygon.length];
    best = Math.min(best, distancePointToSegment(point, start, end));
  }
  return best;
}

function trimLength(segment) {
  return Math.hypot(
    segment.end[0] - segment.start[0],
    segment.end[1] - segment.start[1],
  );
}

const sourceMap = JSON.parse(fs.readFileSync(sourceMapPath, "utf8"));
assertArray(sourceMap.solid_terrain, "solid_terrain must be an array");

if (sourceMap.map_id !== "area_01_runtime_source_map_v2") {
  fail(`unexpected map_id ${sourceMap.map_id}`);
}

const terrainIds = new Set();
const trimIds = new Set();
let trimCount = 0;

for (const terrain of sourceMap.solid_terrain) {
  if (!terrain || typeof terrain !== "object") {
    fail("solid_terrain entries must be objects");
  }

  if (!terrain.id || typeof terrain.id !== "string") {
    fail("solid_terrain entry is missing id");
  }
  if (terrainIds.has(terrain.id)) {
    fail(`duplicate terrain id ${terrain.id}`);
  }
  terrainIds.add(terrain.id);

  assertArray(terrain.polygon, `${terrain.id} polygon must be an array`);
  if (terrain.polygon.length < 3 || !terrain.polygon.every(isPoint)) {
    fail(`${terrain.id} polygon must contain at least three numeric points`);
  }

  if (!terrain.runtime_generation || typeof terrain.runtime_generation !== "object") {
    fail(`${terrain.id} is missing runtime_generation metadata`);
  }

  assertArray(terrain.trim_segments, `${terrain.id} must declare semantic trim_segments`);
  if (terrain.trim_segments.length === 0) {
    fail(`${terrain.id} must include at least one semantic trim segment`);
  }

  for (const segment of terrain.trim_segments) {
    if (!segment || typeof segment !== "object") {
      fail(`${terrain.id} trim segment must be an object`);
    }
    if (!segment.id || typeof segment.id !== "string") {
      fail(`${terrain.id} has a trim segment without an id`);
    }
    if (trimIds.has(segment.id)) {
      fail(`duplicate trim segment id ${segment.id}`);
    }
    trimIds.add(segment.id);

    if (!allowedTrimTypes.has(segment.type)) {
      fail(`${segment.id} has unsupported trim type ${segment.type}`);
    }
    if (!isPoint(segment.start) || !isPoint(segment.end)) {
      fail(`${segment.id} must include numeric start and end points`);
    }
    if (trimLength(segment) < 16) {
      fail(`${segment.id} is too short to be a meaningful terrain trim`);
    }

    for (const key of ["repeat_spacing", "scale", "alpha"]) {
      if (segment[key] !== undefined && !Number.isFinite(segment[key])) {
        fail(`${segment.id} ${key} must be numeric when present`);
      }
    }

    const startDistance = distancePointToPolygonEdge(segment.start, terrain.polygon);
    const endDistance = distancePointToPolygonEdge(segment.end, terrain.polygon);
    if (startDistance > MAX_EDGE_DISTANCE || endDistance > MAX_EDGE_DISTANCE) {
      fail(
        `${segment.id} endpoints must lie on ${terrain.id} polygon edges ` +
          `(start ${startDistance.toFixed(2)}, end ${endDistance.toFixed(2)})`,
      );
    }

    trimCount += 1;
  }
}

console.log(
  `PASS Area 01 runtime source map validation: ${terrainIds.size} terrain polygons, ${trimCount} semantic trim segments.`,
);
