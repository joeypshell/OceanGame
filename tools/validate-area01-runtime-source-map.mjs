import fs from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const sourceMapPath = path.join(
  repoRoot,
  "docs",
  "planning",
  "maps",
  "area_01_runtime_source_map_v3.json",
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

function polygonCenter(polygon) {
  const totals = polygon.reduce(
    (accumulator, point) => [accumulator[0] + point[0], accumulator[1] + point[1]],
    [0, 0],
  );
  return [totals[0] / polygon.length, totals[1] / polygon.length];
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

function polygonArea(points) {
  let total = 0;
  for (let index = 0; index < points.length; index += 1) {
    const point = points[index];
    const nextPoint = points[(index + 1) % points.length];
    total += point[0] * nextPoint[1] - nextPoint[0] * point[1];
  }
  return Math.abs(total) * 0.5;
}

function trimLength(segment) {
  return Math.hypot(
    segment.end[0] - segment.start[0],
    segment.end[1] - segment.start[1],
  );
}

const sourceMap = JSON.parse(fs.readFileSync(sourceMapPath, "utf8"));
assertArray(sourceMap.solid_terrain, "solid_terrain must be an array");
assertArray(sourceMap.playable_water_regions, "playable_water_regions must be an array");

if (sourceMap.map_id !== "area_01_runtime_source_map_v3") {
  fail(`unexpected map_id ${sourceMap.map_id}`);
}

if (sourceMap.status !== "active_runtime_surface_floor_geometry_collision_authority") {
  fail(`unexpected status ${sourceMap.status}`);
}

const runtimeAuthority = String(
  sourceMap.coordinate_space?.runtime_authority ?? "",
).toLowerCase();
if (
  runtimeAuthority.includes("planning-only") ||
  !runtimeAuthority.includes("current area 01 geometry/collision authority")
) {
  fail("coordinate_space.runtime_authority must identify runtime v3 as the current Area 01 authority");
}

if (sourceMap.generation_model?.strategy !== "playable_water_first") {
  fail("generation_model.strategy must be playable_water_first");
}
if (!String(sourceMap.generation_model?.primary_source ?? "").includes("area_01_playable_water_trace_v1")) {
  fail("generation_model.primary_source must name area_01_playable_water_trace_v1 as the primary cave topology source");
}
if (sourceMap.playable_water_trace?.status !== "generated_source_png_playable_water_trace") {
  fail("playable_water_trace metadata must point at the generated source PNG trace");
}
if (sourceMap.playable_water_trace?.region_count < 6) {
  fail("playable_water_trace must include traced cave/corridor regions");
}
if (!String(sourceMap.generation_model?.solid_terrain_policy ?? "").includes("Do not copy hand-authored solid_terrain")) {
  fail("generation_model.solid_terrain_policy must reject hand-authored solid chunks as primary source");
}

const terrainDomain = sourceMap.terrain_domain;
if (!terrainDomain || typeof terrainDomain !== "object") {
  fail("terrain_domain object is required");
}
assertArray(terrainDomain.polygon, "terrain_domain polygon must be an array");
if (terrainDomain.polygon.length < 3 || !terrainDomain.polygon.every(isPoint)) {
  fail("terrain_domain polygon must contain at least three numeric points");
}
if (terrainDomain.runtime_generation?.visual_role !== "continuous_terrain_domain") {
  fail("terrain_domain must own the continuous_terrain_domain visual role");
}

const terrainDomainArea = polygonArea(terrainDomain.polygon);
const waterIds = new Set();
const carvingWaterIds = new Set();
const sourceRegionWaterIds = new Set();
for (const water of sourceMap.playable_water_regions) {
  if (!water || typeof water !== "object") {
    fail("playable_water_regions entries must be objects");
  }
  if (!water.id || typeof water.id !== "string") {
    fail("playable_water_regions entry is missing id");
  }
  if (waterIds.has(water.id)) {
    fail(`duplicate playable water id ${water.id}`);
  }
  waterIds.add(water.id);
  assertArray(water.polygon, `${water.id} polygon must be an array`);
  if (water.polygon.length < 3 || !water.polygon.every(isPoint)) {
    fail(`${water.id} polygon must contain at least three numeric points`);
  }
  if (water.runtime_generation?.visual_role !== "playable_water_cutout") {
    fail(`${water.id} must own the playable_water_cutout visual role`);
  }
  if (!water.runtime_generation?.visible_polygon2d_name || !water.runtime_generation?.edge_line2d_name) {
    fail(`${water.id} must name generated cutout and edge visuals`);
  }
  if (water.carves_collision) {
    carvingWaterIds.add(water.id);
  }
  if (water.source_region_id) {
    sourceRegionWaterIds.add(water.source_region_id);
  }
  if (Array.isArray(water.source_region_ids)) {
    for (const regionId of water.source_region_ids) {
      sourceRegionWaterIds.add(regionId);
    }
  }
}
if (carvingWaterIds.size < 6) {
  fail("playable_water_regions must include carved cave and cave-mouth shapes");
}

assertArray(sourceMap.regions, "regions must be an array");
for (const region of sourceMap.regions) {
  const kind = String(region.kind ?? "");
  if (["cave", "pocket", "locked_promise"].includes(kind) && !sourceRegionWaterIds.has(region.id)) {
    fail(`${region.id} ${kind} region must have a matching playable_water_regions entry`);
  }
}

const terrainIds = new Set();
const trimIds = new Set();
let trimCount = 0;
const terrainPolygons = [];
let collisionPartitionCount = 0;
let solidArea = 0;

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

  terrainPolygons.push({ id: terrain.id, polygon: terrain.polygon });
  solidArea += polygonArea(terrain.polygon);

  if (!terrain.runtime_generation || typeof terrain.runtime_generation !== "object") {
    fail(`${terrain.id} is missing runtime_generation metadata`);
  }
  if (!terrain.runtime_generation.collision_polygon2d_name) {
    fail(`${terrain.id} must name generated collision`);
  }
  if (terrain.runtime_generation.collision_points_source !== "this polygon") {
    fail(`${terrain.id} collision must use this source polygon`);
  }
  if (terrain.runtime_generation.sprites_define_collision !== false) {
    fail(`${terrain.id} sprites must not define collision`);
  }

  const visualRole = String(terrain.runtime_generation.visual_role ?? "solid_terrain");
  if (visualRole === "collision_partition") {
    collisionPartitionCount += 1;
    const algorithm = String(terrain.generation_source?.algorithm ?? "");
    if (!algorithm.includes("terrain_domain_minus_playable_water")) {
      fail(`${terrain.id} collision partition must declare water-shape generation source`);
    }
    const carved = terrain.generation_source?.carved_playable_water_regions;
    assertArray(carved, `${terrain.id} generation_source.carved_playable_water_regions must be an array`);
    for (const id of carved) {
      if (!waterIds.has(id)) {
        fail(`${terrain.id} references unknown carved playable water region ${id}`);
      }
    }
    if (terrain.trim_segments !== undefined && !Array.isArray(terrain.trim_segments)) {
      fail(`${terrain.id} trim_segments must be an array when present`);
    }
    continue;
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

if (collisionPartitionCount !== sourceMap.solid_terrain.length) {
  fail("runtime v3 solid_terrain entries must be generated collision partitions in the water-shape-first model");
}
if (solidArea < terrainDomainArea * 0.35) {
  fail("generated solid collision area is too small to represent a continuous undersea terrain mass");
}

assertArray(sourceMap.scene_hooks, "scene_hooks must be an array");
const hooksById = new Map();
for (const hook of sourceMap.scene_hooks) {
  if (!hook || typeof hook !== "object" || typeof hook.id !== "string") {
    fail("scene_hooks entries must be objects with ids");
  }
  if (hooksById.has(hook.id)) {
    fail(`duplicate scene hook id ${hook.id}`);
  }
  assertArray(hook.points, `${hook.id} points must be an array`);
  if (hook.points.length < 3 || !hook.points.every(isPoint)) {
    fail(`${hook.id} must contain at least three numeric points`);
  }
  hooksById.set(hook.id, hook);
}

const surfaceHook = hooksById.get("surface_oxygen_refill_zone");
if (!surfaceHook || surfaceHook.type !== "oxygen") {
  fail("surface_oxygen_refill_zone oxygen hook is required");
}
const surfaceBounds = polygonBounds(surfaceHook.points);
if (surfaceBounds.minX > -850 || surfaceBounds.maxX < 4500 || surfaceBounds.maxY < 320) {
  fail("surface oxygen hook must keep the full top water surface open");
}

const offloadHook = hooksById.get("ship_offload_zone");
if (!offloadHook || offloadHook.type !== "offload") {
  fail("ship_offload_zone offload hook is required");
}
if (offloadHook.id === surfaceHook.id) {
  fail("ship offload and oxygen refill hooks must stay separate");
}

for (const terrain of terrainPolygons) {
  const bounds = polygonBounds(terrain.polygon);
  if (bounds.minY <= surfaceBounds.maxY) {
    fail(`${terrain.id} overlaps the open-surface oxygen band`);
  }
}

assertArray(sourceMap.cave_mouths, "cave_mouths must be an array");
for (const caveMouth of sourceMap.cave_mouths) {
  if (!caveMouth || typeof caveMouth !== "object") {
    fail("cave_mouths entries must be objects");
  }
  const caveId = caveMouth.id ?? "unknown";
  const sceneHook = caveMouth.scene_hook;
  if (!sceneHook || !hooksById.has(sceneHook)) {
    fail(`${caveId} must reference an existing scene hook`);
  }
  assertArray(caveMouth.entrance_polygon, `${caveId} entrance_polygon must be an array`);
  if (
    caveMouth.entrance_polygon.length < 3 ||
    !caveMouth.entrance_polygon.every(isPoint)
  ) {
    fail(`${caveId} entrance_polygon must contain at least three numeric points`);
  }
  const center = polygonCenter(caveMouth.entrance_polygon);
  for (const terrain of terrainPolygons) {
    if (pointInPolygon(center, terrain.polygon)) {
      fail(`${caveId} entrance center is blocked by ${terrain.id}`);
    }
  }
}

for (const water of sourceMap.playable_water_regions) {
  if (!water.carves_collision) {
    continue;
  }
  const center = polygonCenter(water.polygon);
  for (const terrain of terrainPolygons) {
    if (pointInPolygon(center, terrain.polygon)) {
      fail(`${water.id} playable water center is blocked by ${terrain.id}`);
    }
  }
}

for (const hook of sourceMap.scene_hooks) {
  const center = polygonCenter(hook.points);
  for (const terrain of terrainPolygons) {
    if (pointInPolygon(center, terrain.polygon)) {
      fail(`${hook.id} ${hook.type} hook center is blocked by ${terrain.id}`);
    }
  }
}

for (const placement of sourceMap.sprite_placements ?? []) {
  if (!placement || typeof placement !== "object") {
    fail("sprite_placements entries must be objects");
  }
  if (!isPoint(placement.position)) {
    fail(`${placement.id ?? "unknown sprite"} must include a numeric position`);
  }

  const collisionRole = String(placement.collision_role ?? "none");
  if (collisionRole === "none" || collisionRole === "decorative") {
    for (const terrain of terrainPolygons) {
      if (pointInPolygon(placement.position, terrain.polygon)) {
        fail(`${placement.id} sprite placement overlaps solid terrain ${terrain.id}`);
      }
    }
  }
}

console.log(
  `PASS Area 01 runtime source map validation: ${terrainIds.size} generated collision partitions, ${waterIds.size} playable water shapes, ${trimCount} semantic trim segments, ${hooksById.size} scene hooks.`,
);
