#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import readline from "node:readline";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.join(path.dirname(fileURLToPath(import.meta.url)), ".."));

const resources = [
  ["oceangame://agents", "AGENTS.md", "Agent operating guide"],
  ["oceangame://architecture", "docs/current/ARCHITECTURE.md", "Current architecture"],
  ["oceangame://roadmap", "docs/current/ROADMAP.md", "Current roadmap"],
  ["oceangame://gameplay", "docs/current/GAMEPLAY.md", "Implemented gameplay"],
  ["oceangame://tooling", "docs/current/TOOLING.md", "Current tooling"],
  ["oceangame://godot-mcp", "docs/current/GODOT_MCP.md", "Godot MCP tooling policy"],
  ["oceangame://screenshot-workflow", "docs/current/SCREENSHOT_WORKFLOW.md", "Screenshot workflow"],
  ["oceangame://project-status", "docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md", "Project status review"],
  ["oceangame://core-loop", "docs/planning/CORE_LOOP_RULES.md", "Core loop rules"],
  ["oceangame://seeded-expeditions", "docs/planning/DAILY_RUNS.md", "Seeded expedition guidance"],
  ["oceangame://game-vision", "docs/planning/GAME_VISION.md", "Game vision"],
  ["oceangame://compulsion-identity-2026-06-26", "docs/planning/COMPULSION_IDENTITY_2026_06_26.md", "Compulsion identity direction"],
  ["oceangame://progression-ladder", "docs/planning/PROGRESSION_LADDER.md", "Progression ladder"],
  ["oceangame://predator-direction", "docs/planning/PREDATOR_INTERACTION_DIRECTION.md", "Predator interaction direction"],
  ["oceangame://blind-validation-kit", "docs/planning/BLIND_VALIDATION_KIT.md", "Blind validation kit"],
  ["oceangame://expedition-goal-ii", "docs/planning/EXPEDITION_GOAL_II.md", "Expedition Goal II plan"],
  ["oceangame://scanner-improvement-i", "docs/planning/SCANNER_IMPROVEMENT_I.md", "Scanner Improvement I plan"],
  ["oceangame://scanner-progression-v2", "docs/planning/SCANNER_PROGRESSION_V2.md", "Scanner Progression v2 plan"],
  ["oceangame://cargo-improvement-i", "docs/planning/CARGO_IMPROVEMENT_I.md", "Cargo Improvement I plan"],
  ["oceangame://burst-thruster", "docs/planning/BURST_THRUSTER_MILESTONE.md", "Burst Thruster milestone plan"],
  ["oceangame://monster-observation-i", "docs/planning/MONSTER_OBSERVATION_I.md", "Monster Observation I plan"],
  ["oceangame://monster-research-loop-v1", "docs/planning/MONSTER_RESEARCH_LOOP_V1.md", "Monster Research Loop v1 plan"],
  ["oceangame://predator-warning-i", "docs/planning/PREDATOR_WARNING_I.md", "Predator Warning I plan"],
  ["oceangame://biome-pocket-i", "docs/planning/BIOME_POCKET_I.md", "Biome Pocket I plan"],
  ["oceangame://biome-pocket-ii", "docs/planning/BIOME_POCKET_II.md", "Biome Pocket II plan"],
  ["oceangame://shell-reef-route-review", "docs/planning/SHELL_REEF_ROUTE_REVIEW.md", "Shell Reef route review checklist"],
  ["oceangame://shell-reef-route-review-2026-06-25", "docs/planning/SHELL_REEF_ROUTE_REVIEW_2026_06_25.md", "Shell Reef five-seed review"],
  ["oceangame://surface-ui-layout-pass", "docs/planning/SURFACE_UI_LAYOUT_PASS.md", "Surface UI layout pass"],
  ["oceangame://visual-language-readability-assets", "docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md", "Visual language readability assets"],
  ["oceangame://resource-economy-tuning-i", "docs/planning/RESOURCE_ECONOMY_TUNING_I.md", "Resource Economy Tuning I plan"],
  ["oceangame://thermal-vent-route-review-2026-06-25", "docs/planning/THERMAL_VENT_ROUTE_REVIEW_2026_06_25.md", "Thermal Vent five-seed review"],
  ["oceangame://backlog-replenishment-thermal-vent-decoy", "docs/planning/BACKLOG_REPLENISHMENT_THERMAL_VENT_DECOY_2026_06_25.md", "Thermal Vent and Decoy backlog replenishment"],
  ["oceangame://backlog-replenishment-visual-clarity-foundation-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_VISUAL_CLARITY_FOUNDATION_2026_06_26.md", "Visual clarity foundation backlog replenishment"],
  ["oceangame://backlog-replenishment-after-visual-clarity-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_VISUAL_CLARITY_2026_06_26.md", "Post-visual-clarity backlog replenishment"],
  ["oceangame://backlog-replenishment-after-shell-reef", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_SHELL_REEF_2026_06_25.md", "Post-Shell-Reef backlog replenishment"],
  ["oceangame://backlog-replenishment-2026-06-25", "docs/planning/BACKLOG_REPLENISHMENT_2026_06_25.md", "Backlog replenishment"],
].map(([uri, filePath, name]) => ({
  uri,
  filePath,
  name,
  mimeType: "text/markdown",
}));

function readResource(uri) {
  const resource = resources.find((entry) => entry.uri === uri);
  if (!resource) {
    throw new Error(`Unknown resource: ${uri}`);
  }

  const absolutePath = path.resolve(repoRoot, resource.filePath);
  if (!absolutePath.startsWith(repoRoot)) {
    throw new Error(`Resource escapes repository root: ${resource.filePath}`);
  }

  return {
    uri: resource.uri,
    mimeType: resource.mimeType,
    text: fs.readFileSync(absolutePath, "utf8"),
  };
}

function resultFor(method, params = {}) {
  switch (method) {
    case "initialize":
      return {
        protocolVersion: "2024-11-05",
        capabilities: {
          resources: {},
          tools: {},
          prompts: {},
        },
        serverInfo: {
          name: "oceangame-context",
          version: "0.1.0",
        },
      };
    case "resources/list":
      return {
        resources: resources.map(({ uri, name, mimeType }) => ({ uri, name, mimeType })),
      };
    case "resources/read":
      return {
        contents: [readResource(params.uri)],
      };
    case "tools/list":
      return { tools: [] };
    case "prompts/list":
      return { prompts: [] };
    default:
      throw new Error(`Unsupported method: ${method}`);
  }
}

function respond(message, payload) {
  if (message.id === undefined || message.id === null) {
    return;
  }

  process.stdout.write(`${JSON.stringify({ jsonrpc: "2.0", id: message.id, ...payload })}\n`);
}

async function serve() {
  const rl = readline.createInterface({
    input: process.stdin,
    crlfDelay: Number.POSITIVE_INFINITY,
  });

  for await (const line of rl) {
    const payload = line.replace(/^\uFEFF/, "");
    if (!payload.trim()) {
      continue;
    }

    let message;
    try {
      message = JSON.parse(payload);
      if (message.method?.startsWith("notifications/")) {
        continue;
      }
      respond(message, { result: resultFor(message.method, message.params ?? {}) });
    } catch (error) {
      respond(message ?? { id: null }, {
        error: {
          code: -32603,
          message: error instanceof Error ? error.message : String(error),
        },
      });
    }
  }
}

function selfTest() {
  const listed = resultFor("resources/list").resources;
  const roadmap = readResource("oceangame://roadmap");
  const listedUris = new Set(listed.map((resource) => resource.uri));
  const requiredUris = [
    "oceangame://roadmap",
    "oceangame://expedition-goal-ii",
    "oceangame://backlog-replenishment-after-shell-reef",
    "oceangame://thermal-vent-route-review-2026-06-25",
    "oceangame://compulsion-identity-2026-06-26",
    "oceangame://backlog-replenishment-visual-clarity-foundation-2026-06-26",
    "oceangame://screenshot-workflow",
    "oceangame://monster-research-loop-v1",
    "oceangame://scanner-progression-v2",
    "oceangame://backlog-replenishment-after-visual-clarity-2026-06-26",
    "oceangame://project-status",
  ];
  if (
    listed.length < 1 ||
    !roadmap.text.includes("# Current Roadmap") ||
    requiredUris.some((uri) => !listedUris.has(uri))
  ) {
    throw new Error("MCP context self-test failed");
  }
  process.stdout.write(`OceanGame MCP context server self-test passed (${listed.length} resources).\n`);
}

if (process.argv.includes("--self-test")) {
  selfTest();
} else {
  serve();
}
