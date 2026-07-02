#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  connectedWaterComponents,
  validateGeneratedCoverage,
  validateSourceGrid,
  validateTopology,
} from "./area01-map/grid-helpers.mjs";
import { buildRuntimeGeometry } from "./area01-map/runtime-geometry.mjs";
import { diffPreviewSvg, runtimePreviewSvg, sourcePreviewSvg } from "./area01-map/previews.mjs";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const SOURCE_PATH = path.join(ROOT, "data", "maps", "area_01_source_grid_v1.json");
const RUNTIME_PATH = path.join(ROOT, "data", "maps", "area_01_runtime_geometry.generated.json");
const ARTIFACT_DIR = path.join(ROOT, "artifacts", "maps");
const SOURCE_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_source_grid_preview.svg");
const RUNTIME_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_runtime_geometry_preview.svg");
const DIFF_PREVIEW_PATH = path.join(ARTIFACT_DIR, "area_01_diff_overlay.svg");

export function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

export function writeJson(filePath, value) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, `${JSON.stringify(value, null, 2)}\n`, "utf8");
}

export function writeText(filePath, value) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, value, "utf8");
}

export function fail(errors) {
  for (const error of errors) {
    console.error(`FAIL ${error}`);
  }
  process.exit(1);
}

export function parseArgs(argv) {
  const args = new Set(argv.slice(2));
  return {
    validate: args.has("--validate") || args.size === 0,
    write: args.has("--write"),
    previews: args.has("--previews") || args.has("--write-previews"),
  };
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
