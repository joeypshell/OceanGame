import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const defaultSourceMapPath = path.join(
  repoRoot,
  "docs",
  "planning",
  "maps",
  "area_01_runtime_source_map_v3.json",
);

const REQUIRED_REVIEW_POINT_IDS = new Set([
  "surface_entry_open_water",
  "starter_kelp_cave_frame",
  "central_drop_thermal_vent_frame",
  "pressure_wreck_branch_frame",
  "future_deep_exit_frame",
]);

function fail(message) {
  throw new Error(`Area 01 playable-water framing validation failed: ${message}`);
}

function resolveSourceMapPath() {
  const sourceFlagIndex = process.argv.indexOf("--source");
  if (sourceFlagIndex === -1) {
    return defaultSourceMapPath;
  }
  const sourcePath = process.argv[sourceFlagIndex + 1];
  if (!sourcePath) {
    fail("--source requires a path argument");
  }
  return path.resolve(repoRoot, sourcePath);
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

function pointInPolygon(point, polygon) {
  let inside = false;
  for (
    let index = 0, previous = polygon.length - 1;
    index < polygon.length;
    previous = index++
  ) {
    const currentPoint = polygon[index];
    const previousPoint = polygon[previous];
    const crosses =
      currentPoint[1] > point[1] !== previousPoint[1] > point[1] &&
      point[0] <
        ((previousPoint[0] - currentPoint[0]) * (point[1] - currentPoint[1])) /
          (previousPoint[1] - currentPoint[1]) +
          currentPoint[0];
    if (crosses) {
      inside = !inside;
    }
  }
  return inside;
}

function polygonArea(points) {
  let total = 0;
  for (let index = 0; index < points.length; index += 1) {
    const point = points[index];
    const nextPoint = points[(index + 1) % points.length];
    total += point[0] * nextPoint[1] - nextPoint[0] * point[1];
  }
  return Math.abs(total) * 0.5;
}

function polygonBounds(points) {
  return points.reduce(
    (bounds, point) => ({
      minX: Math.min(bounds.minX, point[0]),
      maxX: Math.max(bounds.maxX, point[0]),
      minY: Math.min(bounds.minY, point[1]),
      maxY: Math.max(bounds.maxY, point[1]),
    }),
    {
      minX: Infinity,
      maxX: -Infinity,
      minY: Infinity,
      maxY: -Infinity,
    },
  );
}

function viewRect(focus, cameraSize) {
  return {
    minX: focus[0] - cameraSize[0] * 0.5,
    maxX: focus[0] + cameraSize[0] * 0.5,
    minY: focus[1] - cameraSize[1] * 0.5,
    maxY: focus[1] + cameraSize[1] * 0.5,
  };
}

function rectArea(rect) {
  return Math.max(0, rect.maxX - rect.minX) * Math.max(0, rect.maxY - rect.minY);
}

function edgeBandRects(rect, bandSize) {
  const clampedBandSize = Math.max(
    1,
    Math.min(bandSize, (rect.maxX - rect.minX) * 0.5, (rect.maxY - rect.minY) * 0.5),
  );
  return {
    top: { ...rect, maxY: rect.minY + clampedBandSize },
    bottom: { ...rect, minY: rect.maxY - clampedBandSize },
    left: { ...rect, maxX: rect.minX + clampedBandSize },
    right: { ...rect, minX: rect.maxX - clampedBandSize },
  };
}

function clipPolygonWithBoundary(points, inside, intersection) {
  if (points.length === 0) {
    return [];
  }

  const clipped = [];
  for (let index = 0; index < points.length; index += 1) {
    const current = points[index];
    const previous = points[(index + points.length - 1) % points.length];
    const currentInside = inside(current);
    const previousInside = inside(previous);

    if (currentInside) {
      if (!previousInside) {
        clipped.push(intersection(previous, current));
      }
      clipped.push(current);
    } else if (previousInside) {
      clipped.push(intersection(previous, current));
    }
  }

  return clipped;
}

function interpolateAtX(start, end, x) {
  const deltaX = end[0] - start[0];
  if (deltaX === 0) {
    return [x, start[1]];
  }
  const t = (x - start[0]) / deltaX;
  return [x, start[1] + (end[1] - start[1]) * t];
}

function interpolateAtY(start, end, y) {
  const deltaY = end[1] - start[1];
  if (deltaY === 0) {
    return [start[0], y];
  }
  const t = (y - start[1]) / deltaY;
  return [start[0] + (end[0] - start[0]) * t, y];
}

function clipPolygonToRect(polygon, rect) {
  let clipped = polygon.map((point) => [point[0], point[1]]);
  clipped = clipPolygonWithBoundary(
    clipped,
    (point) => point[0] >= rect.minX,
    (start, end) => interpolateAtX(start, end, rect.minX),
  );
  clipped = clipPolygonWithBoundary(
    clipped,
    (point) => point[0] <= rect.maxX,
    (start, end) => interpolateAtX(start, end, rect.maxX),
  );
  clipped = clipPolygonWithBoundary(
    clipped,
    (point) => point[1] >= rect.minY,
    (start, end) => interpolateAtY(start, end, rect.minY),
  );
  clipped = clipPolygonWithBoundary(
    clipped,
    (point) => point[1] <= rect.maxY,
    (start, end) => interpolateAtY(start, end, rect.maxY),
  );
  return clipped;
}

function polygonRectIntersectionArea(polygon, rect) {
  const bounds = polygonBounds(polygon);
  if (
    bounds.maxX <= rect.minX ||
    bounds.minX >= rect.maxX ||
    bounds.maxY <= rect.minY ||
    bounds.minY >= rect.maxY
  ) {
    return 0;
  }
  const clipped = clipPolygonToRect(polygon, rect);
  return clipped.length >= 3 ? polygonArea(clipped) : 0;
}

function solidAreaInRect(solids, rect) {
  return solids.reduce(
    (total, solid) => total + polygonRectIntersectionArea(solid.polygon, rect),
    0,
  );
}

function ratiosForReviewPoint(solids, rect, bandSize) {
  const fullArea = rectArea(rect);
  const solidArea = solidAreaInRect(solids, rect);
  const bands = edgeBandRects(rect, bandSize);
  const sideRatios = {};
  for (const [side, bandRect] of Object.entries(bands)) {
    const bandArea = rectArea(bandRect);
    sideRatios[side] = bandArea > 0 ? solidAreaInRect(solids, bandRect) / bandArea : 0;
  }
  return {
    solidAreaRatio: fullArea > 0 ? solidArea / fullArea : 0,
    sideRatios,
  };
}

function formatRatio(value) {
  return value.toFixed(3);
}

function validatePointShape(point, label) {
  if (!isPoint(point)) {
    fail(`${label} must be a numeric [x, y] point`);
  }
}

const sourceMapPath = resolveSourceMapPath();
const sourceMap = JSON.parse(fs.readFileSync(sourceMapPath, "utf8"));
if (sourceMap.map_id !== "area_01_runtime_source_map_v3") {
  fail(`unexpected map_id ${sourceMap.map_id}`);
}

assertArray(sourceMap.camera_review_points, "camera_review_points must be an array");
assertArray(sourceMap.playable_water_regions, "playable_water_regions must be an array");
assertArray(sourceMap.solid_terrain, "solid_terrain must be an array");

const terrainDomain = sourceMap.terrain_domain;
if (!terrainDomain || typeof terrainDomain !== "object") {
  fail("terrain_domain object is required");
}
assertArray(terrainDomain.polygon, "terrain_domain polygon must be an array");
if (!terrainDomain.polygon.every(isPoint)) {
  fail("terrain_domain polygon must contain numeric points");
}
const terrainTopY = polygonBounds(terrainDomain.polygon).minY;

const waterById = new Map();
for (const water of sourceMap.playable_water_regions) {
  if (!water || typeof water !== "object" || typeof water.id !== "string") {
    fail("playable_water_regions entries must be objects with string ids");
  }
  assertArray(water.polygon, `${water.id} polygon must be an array`);
  if (water.polygon.length < 3 || !water.polygon.every(isPoint)) {
    fail(`${water.id} polygon must contain at least three numeric points`);
  }
  waterById.set(water.id, water);
}

const solids = sourceMap.solid_terrain.filter((solid) => solid.blocks_player !== false);
for (const solid of solids) {
  if (!solid || typeof solid !== "object" || typeof solid.id !== "string") {
    fail("solid_terrain entries must be objects with string ids");
  }
  assertArray(solid.polygon, `${solid.id} polygon must be an array`);
  if (solid.polygon.length < 3 || !solid.polygon.every(isPoint)) {
    fail(`${solid.id} polygon must contain at least three numeric points`);
  }
}

const seenReviewPointIds = new Set();
let framedPointCount = 0;
let openSurfacePointCount = 0;
const summaries = [];

for (const reviewPoint of sourceMap.camera_review_points) {
  if (!reviewPoint || typeof reviewPoint !== "object" || typeof reviewPoint.id !== "string") {
    fail("camera_review_points entries must be objects with string ids");
  }
  if (seenReviewPointIds.has(reviewPoint.id)) {
    fail(`duplicate camera review point id ${reviewPoint.id}`);
  }
  seenReviewPointIds.add(reviewPoint.id);

  validatePointShape(reviewPoint.focus, `${reviewPoint.id}.focus`);
  if (!Array.isArray(reviewPoint.camera_size) || reviewPoint.camera_size.length !== 2) {
    fail(`${reviewPoint.id}.camera_size must be [width, height]`);
  }
  const cameraSize = reviewPoint.camera_size;
  if (!Number.isFinite(cameraSize[0]) || !Number.isFinite(cameraSize[1])) {
    fail(`${reviewPoint.id}.camera_size values must be numeric`);
  }
  if (cameraSize[0] < 320 || cameraSize[1] < 240) {
    fail(`${reviewPoint.id}.camera_size is too small to represent a camera-scale review`);
  }

  assertArray(
    reviewPoint.expected_water_region_ids,
    `${reviewPoint.id}.expected_water_region_ids must be an array`,
  );
  const waterHits = [];
  for (const waterId of reviewPoint.expected_water_region_ids) {
    const water = waterById.get(waterId);
    if (!water) {
      fail(`${reviewPoint.id} references unknown playable water region ${waterId}`);
    }
    if (pointInPolygon(reviewPoint.focus, water.polygon)) {
      waterHits.push(water);
    }
  }
  if (waterHits.length === 0) {
    fail(`${reviewPoint.id} focus point is not inside any expected playable water region`);
  }

  const bandSize = Number.isFinite(reviewPoint.side_band_size)
    ? reviewPoint.side_band_size
    : 140;
  const rect = viewRect(reviewPoint.focus, cameraSize);
  const ratios = ratiosForReviewPoint(solids, rect, bandSize);
  const requiresTerrainFraming = reviewPoint.requires_terrain_framing === true;

  if (requiresTerrainFraming) {
    framedPointCount += 1;
    if (reviewPoint.focus[1] <= terrainTopY + 80) {
      fail(`${reviewPoint.id} is marked as framed cave water but is not below the seafloor`);
    }
    if (!waterHits.some((water) => water.carves_collision === true)) {
      fail(`${reviewPoint.id} must sit inside a carving playable-water region`);
    }

    const minSolidAreaRatio = Number.isFinite(reviewPoint.min_solid_area_ratio)
      ? reviewPoint.min_solid_area_ratio
      : 0.1;
    if (ratios.solidAreaRatio < minSolidAreaRatio) {
      fail(
        `${reviewPoint.id} camera region is mostly unframed water: ` +
          `solid area ratio ${formatRatio(ratios.solidAreaRatio)} < ${formatRatio(minSolidAreaRatio)}`,
      );
    }

    const minSideSolidRatio = Number.isFinite(reviewPoint.min_side_solid_ratio)
      ? reviewPoint.min_side_solid_ratio
      : 0.12;
    const minFramedSides = Number.isFinite(reviewPoint.min_framed_sides)
      ? reviewPoint.min_framed_sides
      : 2;
    const framedSides = Object.entries(ratios.sideRatios)
      .filter(([, ratio]) => ratio >= minSideSolidRatio)
      .map(([side]) => side);
    if (framedSides.length < minFramedSides) {
      fail(
        `${reviewPoint.id} camera region does not have enough solid terrain framing: ` +
          `${framedSides.length} framed sides < ${minFramedSides}; side ratios ` +
          Object.entries(ratios.sideRatios)
            .map(([side, ratio]) => `${side}=${formatRatio(ratio)}`)
            .join(", "),
      );
    }
    summaries.push(`${reviewPoint.id}: cave ${formatRatio(ratios.solidAreaRatio)} ${framedSides.join("/")}`);
  } else {
    openSurfacePointCount += 1;
    if (reviewPoint.focus[1] >= terrainTopY) {
      fail(`${reviewPoint.id} is marked as open surface but is not above the seafloor`);
    }
    const maxTopBandSolidRatio = Number.isFinite(reviewPoint.max_top_band_solid_ratio)
      ? reviewPoint.max_top_band_solid_ratio
      : 0.02;
    if (ratios.sideRatios.top > maxTopBandSolidRatio) {
      fail(
        `${reviewPoint.id} open-surface camera has solid terrain in the top band: ` +
          `${formatRatio(ratios.sideRatios.top)} > ${formatRatio(maxTopBandSolidRatio)}`,
      );
    }
    summaries.push(`${reviewPoint.id}: surface top=${formatRatio(ratios.sideRatios.top)}`);
  }
}

for (const requiredId of REQUIRED_REVIEW_POINT_IDS) {
  if (!seenReviewPointIds.has(requiredId)) {
    fail(`missing required camera review point ${requiredId}`);
  }
}

if (openSurfacePointCount < 1) {
  fail("at least one intentional open-surface camera review point is required");
}
if (framedPointCount < 4) {
  fail("at least four framed underwater cave/pocket camera review points are required");
}

console.log(
  `PASS Area 01 playable-water framing validation: ${openSurfacePointCount} open-surface and ${framedPointCount} underwater review points checked (${summaries.join("; ")}).`,
);
