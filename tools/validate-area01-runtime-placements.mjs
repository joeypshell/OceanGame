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
const scenePath = path.join(repoRoot, "scenes", "Main.tscn");

const POSITION_KEYS = new Set(["position", "move_start", "move_end", "patrol_start", "patrol_end"]);
const STRING_KEYS = new Set(["spawn_id", "category", "target_id", "route_id", "discovery_id", "display_name"]);
const VALIDATED_SPAWN_ROOTS = ["StarterResourceCandidates", "CreatureRouteCandidates"];
const VALIDATED_DIRECT_ROOTS = ["ResourcePickups", "Creatures", "Predators", "Discoveries"];

function fail(message) {
  throw new Error(`Area 01 runtime placement validation failed: ${message}`);
}

function parseVector2(value) {
  const match = /Vector2\(\s*(-?\d+(?:\.\d+)?),\s*(-?\d+(?:\.\d+)?)\s*\)/.exec(value);
  if (!match) {
    return null;
  }
  return {
    x: Number.parseFloat(match[1]),
    y: Number.parseFloat(match[2]),
  };
}

function pointLabel(point) {
  return `${point.x.toFixed(1)}, ${point.y.toFixed(1)}`;
}

function pointInPolygon(point, polygon) {
  let inside = false;
  for (let index = 0, previous = polygon.length - 1; index < polygon.length; previous = index++) {
    const currentPoint = polygon[index];
    const previousPoint = polygon[previous];
    const intersects =
      currentPoint[1] > point.y !== previousPoint[1] > point.y &&
      point.x <
        ((previousPoint[0] - currentPoint[0]) * (point.y - currentPoint[1])) /
          (previousPoint[1] - currentPoint[1]) +
          currentPoint[0];
    if (intersects) {
      inside = !inside;
    }
  }
  return inside;
}

function solidContainingPoint(point, solids) {
  return solids.find((solid) => pointInPolygon(point, solid.polygon));
}

function playableWaterContainingPoint(point, playableWaterRegions) {
  return playableWaterRegions.find((water) => pointInPolygon(point, water.polygon));
}

function rectFromArray(value) {
  if (!Array.isArray(value) || value.length !== 4) {
    return null;
  }
  const [x, y, width, height] = value;
  if (![x, y, width, height].every(Number.isFinite)) {
    return null;
  }
  return {
    minX: x,
    minY: y,
    maxX: x + width,
    maxY: y + height,
  };
}

function pointInRect(point, rect) {
  return (
    point.x >= rect.minX &&
    point.x <= rect.maxX &&
    point.y >= rect.minY &&
    point.y <= rect.maxY
  );
}

function parseSceneNodes(sceneText) {
  const nodes = [];
  let currentNode = null;

  for (const line of sceneText.split(/\r?\n/)) {
    const nodeMatch = /^\[node name="([^"]+)"(?: type="([^"]+)")? parent="([^"]*)"/.exec(line);
    if (nodeMatch) {
      currentNode = {
        name: nodeMatch[1],
        type: nodeMatch[2] ?? "",
        parent: nodeMatch[3],
        props: {},
      };
      nodes.push(currentNode);
      continue;
    }

    if (!currentNode) {
      continue;
    }

    const propertyMatch = /^([A-Za-z0-9_]+) = (.+)$/.exec(line);
    if (!propertyMatch) {
      continue;
    }

    const key = propertyMatch[1];
    const value = propertyMatch[2];
    if (POSITION_KEYS.has(key)) {
      const point = parseVector2(value);
      if (point) {
        currentNode.props[key] = point;
      }
    } else if (STRING_KEYS.has(key)) {
      const stringMatch = /^"([^"]*)"/.exec(value);
      if (stringMatch) {
        currentNode.props[key] = stringMatch[1];
      }
    } else if (key === "visible") {
      currentNode.props.visible = value.trim() !== "false";
    }
  }

  return nodes;
}

function assignNodePaths(nodes) {
  const byPath = new Map();
  for (const node of nodes) {
    node.path = node.parent && node.parent !== "." ? `${node.parent}/${node.name}` : node.name;
    byPath.set(node.path, node);
  }
  return byPath;
}

function parentNode(node, byPath) {
  if (!node.parent || node.parent === ".") {
    return null;
  }
  return byPath.get(node.parent) ?? null;
}

function isHidden(node, byPath) {
  let cursor = node;
  const visited = new Set();
  while (cursor) {
    if (visited.has(cursor.path)) {
      fail(`scene parent cycle while checking visibility for ${node.path}`);
    }
    visited.add(cursor.path);
    if (cursor.props.visible === false) {
      return true;
    }
    cursor = parentNode(cursor, byPath);
  }
  return false;
}

function globalNodePosition(node, byPath) {
  const position = { x: 0, y: 0 };
  let cursor = node;
  const visited = new Set();
  while (cursor) {
    if (visited.has(cursor.path)) {
      fail(`scene parent cycle while calculating position for ${node.path}`);
    }
    visited.add(cursor.path);
    if (cursor.props.position) {
      position.x += cursor.props.position.x;
      position.y += cursor.props.position.y;
    }
    cursor = parentNode(cursor, byPath);
  }
  return position;
}

function hasValidatedSpawnRoot(node) {
  return VALIDATED_SPAWN_ROOTS.some((root) => node.path === root || node.path.startsWith(`${root}/`));
}

function directRoot(node) {
  return VALIDATED_DIRECT_ROOTS.find((root) => node.parent === root) ?? "";
}

function collectPlacementTargets(nodes, byPath) {
  const targets = [];

  for (const node of nodes) {
    if (isHidden(node, byPath)) {
      continue;
    }

    if (node.props.spawn_id && hasValidatedSpawnRoot(node)) {
      targets.push({
        kind: "spawn point",
        id: [
          node.props.category ?? "resource",
          node.props.target_id ?? node.name,
          node.props.spawn_id,
        ].join(":"),
        path: node.path,
        point: globalNodePosition(node, byPath),
      });
      continue;
    }

    const root = directRoot(node);
    if (!root || !node.props.position) {
      continue;
    }

    const id = node.props.discovery_id ?? node.props.display_name ?? node.name;
    targets.push({
      kind: root === "ResourcePickups" ? "visible pickup" : "authored target",
      id,
      path: node.path,
      point: globalNodePosition(node, byPath),
    });

    for (const endpointKey of ["move_start", "move_end", "patrol_start", "patrol_end"]) {
      const endpoint = node.props[endpointKey];
      if (!endpoint || (endpoint.x === 0 && endpoint.y === 0)) {
        continue;
      }
      targets.push({
        kind: "authored movement endpoint",
        id: `${id}:${endpointKey}`,
        path: node.path,
        point: endpoint,
      });
    }
  }

  return targets;
}

const sourceMap = JSON.parse(fs.readFileSync(sourceMapPath, "utf8"));
const sceneText = fs.readFileSync(scenePath, "utf8");
const solids = sourceMap.solid_terrain.filter((solid) => solid.blocks_player !== false);
const playableWaterRegions = sourceMap.playable_water_regions.filter(
  (water) => water.carves_collision === true || water.kind === "open_surface",
);
const plannedWorldRect = rectFromArray(sourceMap.camera_bounds?.planned_world_rect);

if (sourceMap.map_id !== "area_01_runtime_source_map_v3") {
  fail(`unexpected map_id ${sourceMap.map_id}`);
}
if (!plannedWorldRect) {
  fail("camera_bounds.planned_world_rect must be [x, y, width, height]");
}

const nodes = parseSceneNodes(sceneText);
const byPath = assignNodePaths(nodes);
const targets = collectPlacementTargets(nodes, byPath);
const overlaps = [];
const waterMisses = [];
let legacyOutsideRuntimeMapCount = 0;

for (const target of targets) {
  if (!pointInRect(target.point, plannedWorldRect)) {
    legacyOutsideRuntimeMapCount += 1;
    continue;
  }

  const solid = solidContainingPoint(target.point, solids);
  if (solid) {
    overlaps.push(`${target.kind} ${target.id} at ${target.path} (${pointLabel(target.point)}) overlaps ${solid.id}`);
  }
  const playableWater = playableWaterContainingPoint(target.point, playableWaterRegions);
  if (!playableWater) {
    waterMisses.push(`${target.kind} ${target.id} at ${target.path} (${pointLabel(target.point)}) is outside current Area 01 playable water`);
  }
}

if (overlaps.length > 0) {
  fail(`\n- ${overlaps.join("\n- ")}`);
}
if (waterMisses.length > 0) {
  fail(`\n- ${waterMisses.join("\n- ")}`);
}

console.log(
  `PASS Area 01 runtime placement validation: ${targets.length - legacyOutsideRuntimeMapCount} current Area 01 authored spawn, pickup, creature, and scan positions are inside playable water and outside solid terrain; ${legacyOutsideRuntimeMapCount} legacy lower-route targets are outside the runtime v3 planned world rect.`,
);
