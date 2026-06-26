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
  ["oceangame://solo-first-run-readability-checklist-2026-06-26", "docs/planning/SOLO_FIRST_RUN_READABILITY_CHECKLIST_2026_06_26.md", "Solo first-run readability checklist"],
  ["oceangame://expedition-goal-ii", "docs/planning/EXPEDITION_GOAL_II.md", "Expedition Goal II plan"],
  ["oceangame://scanner-improvement-i", "docs/planning/SCANNER_IMPROVEMENT_I.md", "Scanner Improvement I plan"],
  ["oceangame://scanner-progression-v2", "docs/planning/SCANNER_PROGRESSION_V2.md", "Scanner Progression v2 plan"],
  ["oceangame://deeper-access-after-echo-lens-2026-06-26", "docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md", "Deeper access after Echo Lens plan"],
  ["oceangame://next-milestone-after-vertical-slice-closeout-2026-06-26", "docs/planning/NEXT_MILESTONE_AFTER_VERTICAL_SLICE_CLOSEOUT_2026_06_26.md", "Next milestone after vertical-slice closeout"],
  ["oceangame://wreck-echo-descent-no-implementation-criteria-2026-06-26", "docs/planning/WRECK_ECHO_DESCENT_NO_IMPLEMENTATION_CRITERIA_2026_06_26.md", "Wreck Echo Descent no-implementation criteria"],
  ["oceangame://wreck-echo-descent-route-pocket-data-shape-2026-06-26", "docs/planning/WRECK_ECHO_DESCENT_ROUTE_POCKET_DATA_SHAPE_2026_06_26.md", "Wreck Echo Descent route pocket data shape"],
  ["oceangame://wreck-echo-oxygen-cargo-preparation-review-2026-06-26", "docs/planning/WRECK_ECHO_OXYGEN_CARGO_PREPARATION_REVIEW_2026_06_26.md", "Wreck Echo oxygen/cargo preparation review"],
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
  ["oceangame://visual-replacement-plan", "docs/planning/VISUAL_REPLACEMENT_PLAN.md", "Visual replacement plan"],
  ["oceangame://visual-asset-slot-review-2026-06-26", "docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md", "Visual asset slot review"],
  ["oceangame://asset-source-pipeline-v1", "docs/planning/ASSET_SOURCE_PIPELINE_V1.md", "Asset source pipeline v1"],
  ["oceangame://asset-provenance-review-2026-06-26", "docs/planning/ASSET_PROVENANCE_REVIEW_2026_06_26.md", "Asset provenance review"],
  ["oceangame://active-dive-hud-review-2026-06-26", "docs/planning/ACTIVE_DIVE_HUD_REVIEW_2026_06_26.md", "Active dive HUD review"],
  ["oceangame://playable-vertical-slice-acceptance-checklist-2026-06-26", "docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md", "Playable vertical-slice acceptance checklist"],
  ["oceangame://vertical-slice-acceptance-evidence-bundle-2026-06-26", "docs/planning/VERTICAL_SLICE_ACCEPTANCE_EVIDENCE_BUNDLE_2026_06_26.md", "Vertical-slice acceptance evidence bundle"],
  ["oceangame://playable-vertical-slice-closeout-review-2026-06-26", "docs/planning/PLAYABLE_VERTICAL_SLICE_CLOSEOUT_REVIEW_2026_06_26.md", "Playable vertical-slice closeout review"],
  ["oceangame://vertical-slice-clean-demo-script-2026-06-26", "docs/planning/VERTICAL_SLICE_CLEAN_DEMO_SCRIPT_2026_06_26.md", "Vertical-slice clean demo script"],
  ["oceangame://next-vertical-slice-milestone-2026-06-26", "docs/planning/NEXT_VERTICAL_SLICE_MILESTONE_2026_06_26.md", "Next vertical-slice milestone"],
  ["oceangame://active-hud-normal-scale-screenshot-review-2026-06-26", "docs/planning/ACTIVE_HUD_NORMAL_SCALE_SCREENSHOT_REVIEW_2026_06_26.md", "Active HUD normal-scale screenshot review"],
  ["oceangame://surface-ready-result-readability-review-2026-06-26", "docs/planning/SURFACE_READY_RESULT_READABILITY_REVIEW_2026_06_26.md", "Surface ready/result readability review"],
  ["oceangame://shell-reef-sprite-fallback-balance-review-2026-06-26", "docs/planning/SHELL_REEF_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md", "Shell Reef sprite/fallback balance review"],
  ["oceangame://thermal-vent-sprite-fallback-balance-review-2026-06-26", "docs/planning/THERMAL_VENT_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md", "Thermal Vent sprite/fallback balance review"],
  ["oceangame://pressure-wreck-cache-sprite-fallback-balance-review-2026-06-26", "docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md", "Pressure wreck/cache sprite/fallback balance review"],
  ["oceangame://gulper-route-danger-readability-review-2026-06-26", "docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md", "Gulper route danger readability review"],
  ["oceangame://playable-vertical-slice-manual-smoke-log-2026-06-26", "docs/planning/PLAYABLE_VERTICAL_SLICE_MANUAL_SMOKE_LOG_2026_06_26.md", "Playable vertical-slice manual smoke log"],
  ["oceangame://next-source-art-replacement-priority-2026-06-26", "docs/planning/NEXT_SOURCE_ART_REPLACEMENT_PRIORITY_2026_06_26.md", "Next source-art replacement priority"],
  ["oceangame://expedition-condition-visual-acceptance-review-2026-06-26", "docs/planning/EXPEDITION_CONDITION_VISUAL_ACCEPTANCE_REVIEW_2026_06_26.md", "Expedition condition visual acceptance review"],
  ["oceangame://result-memory-readability-review-2026-06-26", "docs/planning/RESULT_MEMORY_READABILITY_REVIEW_2026_06_26.md", "Result memory readability review"],
  ["oceangame://upgrade-bay-readability-review-2026-06-26", "docs/planning/UPGRADE_BAY_READABILITY_REVIEW_2026_06_26.md", "Upgrade bay readability review"],
  ["oceangame://clean-save-two-expedition-smoke-pass-2026-06-26", "docs/planning/CLEAN_SAVE_TWO_EXPEDITION_SMOKE_PASS_2026_06_26.md", "Clean-save two-expedition smoke pass"],
  ["oceangame://decoy-pulse-owned-state-review-2026-06-26", "docs/planning/DECOY_PULSE_OWNED_STATE_REVIEW_2026_06_26.md", "Decoy Pulse owned-state review"],
  ["oceangame://lower-route-readability-recheck-2026-06-26", "docs/planning/LOWER_ROUTE_READABILITY_RECHECK_2026_06_26.md", "Lower-route readability recheck"],
  ["oceangame://lower-route-acceptance-cleanup-recheck-2026-06-26", "docs/planning/LOWER_ROUTE_ACCEPTANCE_CLEANUP_RECHECK_2026_06_26.md", "Lower-route acceptance cleanup recheck"],
  ["oceangame://surface-moonpool-waterline-review-2026-06-26", "docs/planning/SURFACE_MOONPOOL_WATERLINE_REVIEW_2026_06_26.md", "Surface moonpool/waterline review"],
  ["oceangame://upgrade-tab-normal-scale-review-2026-06-26", "docs/planning/UPGRADE_TAB_NORMAL_SCALE_REVIEW_2026_06_26.md", "Upgrade tab normal-scale review"],
  ["oceangame://no-debug-surface-capture-sanity-review-2026-06-26", "docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md", "No-debug surface capture sanity review"],
  ["oceangame://pressure-wreck-cache-recheck-after-surface-readability-2026-06-26", "docs/planning/PRESSURE_WRECK_CACHE_RECHECK_AFTER_SURFACE_READABILITY_2026_06_26.md", "Pressure wreck/cache recheck after surface readability"],
  ["oceangame://pressure-wreck-cache-backup-art-pass-constraints-2026-06-26", "docs/planning/PRESSURE_WRECK_CACHE_BACKUP_ART_PASS_CONSTRAINTS_2026_06_26.md", "Pressure wreck/cache backup art-pass constraints"],
  ["oceangame://pressure-dark-threshold-use-decision-2026-06-26", "docs/planning/PRESSURE_DARK_THRESHOLD_USE_DECISION_2026_06_26.md", "Pressure-dark threshold use decision"],
  ["oceangame://condition-visual-normal-scale-review-2026-06-26", "docs/planning/CONDITION_VISUAL_NORMAL_SCALE_REVIEW_2026_06_26.md", "Condition visual normal-scale review"],
  ["oceangame://decoy-pulse-result-memory-hud-smoke-2026-06-26", "docs/planning/DECOY_PULSE_RESULT_MEMORY_HUD_SMOKE_2026_06_26.md", "Decoy Pulse result-memory and HUD smoke note"],
  ["oceangame://echo-lens-cache-pulse-readability-recheck-2026-06-26", "docs/planning/ECHO_LENS_CACHE_PULSE_READABILITY_RECHECK_2026_06_26.md", "Echo Lens cache pulse readability recheck"],
  ["oceangame://surface-moonpool-asset-provenance-requirements-2026-06-26", "docs/planning/SURFACE_MOONPOOL_ASSET_PROVENANCE_REQUIREMENTS_2026_06_26.md", "Surface moonpool asset provenance requirements"],
  ["oceangame://active-prompt-burst-decoy-review-2026-06-26", "docs/planning/ACTIVE_PROMPT_BURST_DECOY_REVIEW_2026_06_26.md", "Active prompt Burst/Decoy review"],
  ["oceangame://first-run-surface-ready-comprehension-review-2026-06-26", "docs/planning/FIRST_RUN_SURFACE_READY_COMPREHENSION_REVIEW_2026_06_26.md", "First-run surface ready comprehension review"],
  ["oceangame://first-run-active-dive-comprehension-review-2026-06-26", "docs/planning/FIRST_RUN_ACTIVE_DIVE_COMPREHENSION_REVIEW_2026_06_26.md", "First-run active dive comprehension review"],
  ["oceangame://save-progression-persistence-expectation-2026-06-26", "docs/planning/SAVE_PROGRESSION_PERSISTENCE_EXPECTATION_2026_06_26.md", "Save/progression persistence expectation"],
  ["oceangame://sub-idle-thrust-normal-scale-recheck-2026-06-26", "docs/planning/SUB_IDLE_THRUST_NORMAL_SCALE_RECHECK_2026_06_26.md", "Sub idle/thrust normal-scale recheck"],
  ["oceangame://sub-idle-thrust-source-art-polish-constraints-2026-06-26", "docs/planning/SUB_IDLE_THRUST_SOURCE_ART_POLISH_CONSTRAINTS_2026_06_26.md", "Sub idle/thrust source-art polish constraints"],
  ["oceangame://surface-launch-return-readability-review-2026-06-26", "docs/planning/SURFACE_LAUNCH_RETURN_READABILITY_REVIEW_2026_06_26.md", "Surface launch/return readability review"],
  ["oceangame://next-source-art-after-moonpool-decision-2026-06-26", "docs/planning/NEXT_SOURCE_ART_AFTER_MOONPOOL_DECISION_2026_06_26.md", "Next source-art after moonpool decision"],
  ["oceangame://surface-panel-contrast-review-after-final-hud-2026-06-26", "docs/planning/SURFACE_PANEL_CONTRAST_REVIEW_AFTER_FINAL_HUD_2026_06_26.md", "Surface panel contrast review after final HUD polish"],
  ["oceangame://debug-telemetry-hidden-state-sanity-review-2026-06-26", "docs/planning/DEBUG_TELEMETRY_HIDDEN_STATE_SANITY_REVIEW_2026_06_26.md", "Debug telemetry hidden-state sanity review"],
  ["oceangame://shallow-midwater-background-art-pass-constraints-2026-06-26", "docs/planning/SHALLOW_MIDWATER_BACKGROUND_ART_PASS_CONSTRAINTS_2026_06_26.md", "Shallow/midwater background art-pass constraints"],
  ["oceangame://shallow-midwater-background-study-wiring-2026-06-26", "docs/planning/SHALLOW_MIDWATER_BACKGROUND_STUDY_WIRING_2026_06_26.md", "Shallow/midwater background study wiring"],
  ["oceangame://shallow-midwater-background-readability-review-2026-06-26", "docs/planning/SHALLOW_MIDWATER_BACKGROUND_READABILITY_REVIEW_2026_06_26.md", "Shallow/midwater background readability review"],
  ["oceangame://next-source-art-after-background-review-2026-06-26", "docs/planning/NEXT_SOURCE_ART_AFTER_BACKGROUND_REVIEW_2026_06_26.md", "Next source-art after background review"],
  ["oceangame://pressure-wreck-cache-source-art-shell-constraints-v2-2026-06-26", "docs/planning/PRESSURE_WRECK_CACHE_SOURCE_ART_SHELL_CONSTRAINTS_V2_2026_06_26.md", "Pressure wreck/cache source-art shell constraints v2"],
  ["oceangame://pressure-wreck-cache-shell-normal-scale-review-2026-06-26", "docs/planning/PRESSURE_WRECK_CACHE_SHELL_NORMAL_SCALE_REVIEW_2026_06_26.md", "Pressure wreck/cache shell normal-scale review"],
  ["oceangame://lower-route-recheck-after-pressure-shell-2026-06-26", "docs/planning/LOWER_ROUTE_RECHECK_AFTER_PRESSURE_SHELL_2026_06_26.md", "Lower-route recheck after pressure shell"],
  ["oceangame://lower-route-recheck-after-background-study-2026-06-26", "docs/planning/LOWER_ROUTE_RECHECK_AFTER_BACKGROUND_STUDY_2026_06_26.md", "Lower-route recheck after background study"],
  ["oceangame://source-art-provenance-checklist-2026-06-26", "docs/planning/SOURCE_ART_PROVENANCE_CHECKLIST_2026_06_26.md", "Source-art provenance checklist"],
  ["oceangame://pressure-shell-provenance-checklist-review-2026-06-26", "docs/planning/PRESSURE_SHELL_PROVENANCE_CHECKLIST_REVIEW_2026_06_26.md", "Pressure shell provenance checklist review"],
  ["oceangame://compact-hud-final-polish-plan-2026-06-26", "docs/planning/COMPACT_HUD_FINAL_POLISH_PLAN_2026_06_26.md", "Compact HUD final polish plan"],
  ["oceangame://compact-hud-final-normal-scale-review-2026-06-26", "docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md", "Compact HUD final normal-scale review"],
  ["oceangame://active-hud-low-oxygen-review-after-prompt-tune-2026-06-26", "docs/planning/ACTIVE_HUD_LOW_OXYGEN_REVIEW_AFTER_PROMPT_TUNE_2026_06_26.md", "Active HUD low-oxygen review after prompt tune"],
  ["oceangame://upgrade-bay-normal-scale-affordance-review-after-copy-tune-2026-06-26", "docs/planning/UPGRADE_BAY_NORMAL_SCALE_AFFORDANCE_REVIEW_AFTER_COPY_TUNE_2026_06_26.md", "Upgrade bay normal-scale affordance review after copy tune"],
  ["oceangame://scanner-feedback-signal-vs-echo-review-2026-06-26", "docs/planning/SCANNER_FEEDBACK_SIGNAL_VS_ECHO_REVIEW_2026_06_26.md", "Scanner feedback Signal Lens vs Echo Lens review"],
  ["oceangame://next-monster-research-readability-milestone-2026-06-26", "docs/planning/NEXT_MONSTER_RESEARCH_READABILITY_MILESTONE_2026_06_26.md", "Next monster research readability milestone"],
  ["oceangame://decoy-pulse-hud-predator-review-after-hud-polish-2026-06-26", "docs/planning/DECOY_PULSE_HUD_PREDATOR_REVIEW_AFTER_HUD_POLISH_2026_06_26.md", "Decoy Pulse HUD and predator review after HUD polish"],
  ["oceangame://gulper-timing-result-clarity-review-2026-06-26", "docs/planning/GULPER_TIMING_RESULT_CLARITY_REVIEW_2026_06_26.md", "Gulper timing result clarity review"],
  ["oceangame://durable-progression-reset-onboarding-review-2026-06-26", "docs/planning/DURABLE_PROGRESSION_RESET_ONBOARDING_REVIEW_2026_06_26.md", "Durable progression reset onboarding review"],
  ["oceangame://upgrade-bay-selection-affordance-review-2026-06-26", "docs/planning/UPGRADE_BAY_SELECTION_AFFORDANCE_REVIEW_2026_06_26.md", "Upgrade bay selection affordance review"],
  ["oceangame://wreck-shelf-echo-lens-route-review-2026-06-26", "docs/planning/WRECK_SHELF_ECHO_LENS_ROUTE_REVIEW_2026_06_26.md", "Wreck Shelf Echo Lens route review"],
  ["oceangame://wreck-echo-readiness-gate-after-shell-hud-2026-06-26", "docs/planning/WRECK_ECHO_READINESS_GATE_AFTER_SHELL_HUD_2026_06_26.md", "Wreck Echo readiness gate after shell and HUD polish"],
  ["oceangame://wreck-echo-reward-choice-2026-06-26", "docs/planning/WRECK_ECHO_REWARD_CHOICE_2026_06_26.md", "Wreck Echo reward choice"],
  ["oceangame://vertical-slice-art-kit-screenshot-checklist-2026-06-26", "docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md", "Vertical slice art kit screenshot checklist"],
  ["oceangame://resource-scan-affordance-review-after-pressure-shell-2026-06-26", "docs/planning/RESOURCE_SCAN_AFFORDANCE_REVIEW_AFTER_PRESSURE_SHELL_2026_06_26.md", "Resource/scan affordance review after pressure shell"],
  ["oceangame://resource-scan-source-art-target-decision-2026-06-26", "docs/planning/RESOURCE_SCAN_SOURCE_ART_TARGET_DECISION_2026_06_26.md", "Resource/scan source-art target decision"],
  ["oceangame://resource-economy-tuning-i", "docs/planning/RESOURCE_ECONOMY_TUNING_I.md", "Resource Economy Tuning I plan"],
  ["oceangame://thermal-vent-route-review-2026-06-25", "docs/planning/THERMAL_VENT_ROUTE_REVIEW_2026_06_25.md", "Thermal Vent five-seed review"],
  ["oceangame://expedition-day-five-seed-review-findings-2026-06-26", "docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_FINDINGS_2026_06_26.md", "Expedition day five-seed review findings"],
  ["oceangame://backlog-replenishment-thermal-vent-decoy", "docs/planning/BACKLOG_REPLENISHMENT_THERMAL_VENT_DECOY_2026_06_25.md", "Thermal Vent and Decoy backlog replenishment"],
  ["oceangame://backlog-replenishment-visual-clarity-foundation-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_VISUAL_CLARITY_FOUNDATION_2026_06_26.md", "Visual clarity foundation backlog replenishment"],
  ["oceangame://backlog-replenishment-after-visual-clarity-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_VISUAL_CLARITY_2026_06_26.md", "Post-visual-clarity backlog replenishment"],
  ["oceangame://backlog-replenishment-playable-loop-polish-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_PLAYABLE_LOOP_POLISH_2026_06_26.md", "Playable loop polish backlog replenishment"],
  ["oceangame://backlog-replenishment-after-playable-loop-polish-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_PLAYABLE_LOOP_POLISH_2026_06_26.md", "Post-playable-loop-polish backlog replenishment"],
  ["oceangame://backlog-replenishment-after-playable-loop-closeout-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_PLAYABLE_LOOP_CLOSEOUT_2026_06_26.md", "Post-playable-loop-closeout backlog replenishment"],
  ["oceangame://backlog-replenishment-vertical-slice-readability-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_VERTICAL_SLICE_READABILITY_2026_06_26.md", "Vertical-slice readability backlog replenishment"],
  ["oceangame://backlog-replenishment-after-vertical-slice-readability-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_VERTICAL_SLICE_READABILITY_2026_06_26.md", "Post-vertical-slice-readability backlog replenishment"],
  ["oceangame://backlog-replenishment-after-vertical-slice-closeout-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_AFTER_VERTICAL_SLICE_CLOSEOUT_2026_06_26.md", "Post-vertical-slice-closeout backlog replenishment"],
  ["oceangame://backlog-replenishment-wreck-echo-prep-review-2026-06-26", "docs/planning/BACKLOG_REPLENISHMENT_WRECK_ECHO_PREP_REVIEW_2026_06_26.md", "Wreck Echo prep backlog review"],
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
    "oceangame://deeper-access-after-echo-lens-2026-06-26",
    "oceangame://next-milestone-after-vertical-slice-closeout-2026-06-26",
    "oceangame://wreck-echo-descent-no-implementation-criteria-2026-06-26",
    "oceangame://wreck-echo-descent-route-pocket-data-shape-2026-06-26",
    "oceangame://wreck-echo-oxygen-cargo-preparation-review-2026-06-26",
    "oceangame://visual-replacement-plan",
    "oceangame://visual-asset-slot-review-2026-06-26",
    "oceangame://asset-source-pipeline-v1",
    "oceangame://asset-provenance-review-2026-06-26",
    "oceangame://active-dive-hud-review-2026-06-26",
    "oceangame://playable-vertical-slice-acceptance-checklist-2026-06-26",
    "oceangame://vertical-slice-acceptance-evidence-bundle-2026-06-26",
    "oceangame://playable-vertical-slice-closeout-review-2026-06-26",
    "oceangame://vertical-slice-clean-demo-script-2026-06-26",
    "oceangame://next-vertical-slice-milestone-2026-06-26",
    "oceangame://backlog-replenishment-vertical-slice-readability-2026-06-26",
    "oceangame://surface-ready-result-readability-review-2026-06-26",
    "oceangame://upgrade-bay-readability-review-2026-06-26",
    "oceangame://clean-save-two-expedition-smoke-pass-2026-06-26",
    "oceangame://surface-moonpool-waterline-review-2026-06-26",
    "oceangame://upgrade-tab-normal-scale-review-2026-06-26",
    "oceangame://no-debug-surface-capture-sanity-review-2026-06-26",
    "oceangame://pressure-wreck-cache-recheck-after-surface-readability-2026-06-26",
    "oceangame://condition-visual-normal-scale-review-2026-06-26",
    "oceangame://decoy-pulse-result-memory-hud-smoke-2026-06-26",
    "oceangame://echo-lens-cache-pulse-readability-recheck-2026-06-26",
    "oceangame://surface-moonpool-asset-provenance-requirements-2026-06-26",
    "oceangame://active-prompt-burst-decoy-review-2026-06-26",
    "oceangame://first-run-surface-ready-comprehension-review-2026-06-26",
    "oceangame://first-run-active-dive-comprehension-review-2026-06-26",
    "oceangame://save-progression-persistence-expectation-2026-06-26",
    "oceangame://sub-idle-thrust-normal-scale-recheck-2026-06-26",
    "oceangame://sub-idle-thrust-source-art-polish-constraints-2026-06-26",
    "oceangame://surface-launch-return-readability-review-2026-06-26",
    "oceangame://next-source-art-after-moonpool-decision-2026-06-26",
    "oceangame://surface-panel-contrast-review-after-final-hud-2026-06-26",
    "oceangame://debug-telemetry-hidden-state-sanity-review-2026-06-26",
    "oceangame://shallow-midwater-background-art-pass-constraints-2026-06-26",
    "oceangame://shallow-midwater-background-study-wiring-2026-06-26",
    "oceangame://shallow-midwater-background-readability-review-2026-06-26",
    "oceangame://next-source-art-after-background-review-2026-06-26",
    "oceangame://pressure-wreck-cache-source-art-shell-constraints-v2-2026-06-26",
    "oceangame://pressure-wreck-cache-shell-normal-scale-review-2026-06-26",
    "oceangame://lower-route-recheck-after-pressure-shell-2026-06-26",
    "oceangame://lower-route-recheck-after-background-study-2026-06-26",
    "oceangame://source-art-provenance-checklist-2026-06-26",
    "oceangame://pressure-shell-provenance-checklist-review-2026-06-26",
    "oceangame://compact-hud-final-polish-plan-2026-06-26",
    "oceangame://compact-hud-final-normal-scale-review-2026-06-26",
    "oceangame://active-hud-low-oxygen-review-after-prompt-tune-2026-06-26",
    "oceangame://upgrade-bay-normal-scale-affordance-review-after-copy-tune-2026-06-26",
    "oceangame://scanner-feedback-signal-vs-echo-review-2026-06-26",
    "oceangame://next-monster-research-readability-milestone-2026-06-26",
    "oceangame://decoy-pulse-hud-predator-review-after-hud-polish-2026-06-26",
    "oceangame://gulper-timing-result-clarity-review-2026-06-26",
    "oceangame://durable-progression-reset-onboarding-review-2026-06-26",
    "oceangame://pressure-dark-threshold-use-decision-2026-06-26",
    "oceangame://upgrade-bay-selection-affordance-review-2026-06-26",
    "oceangame://solo-first-run-readability-checklist-2026-06-26",
    "oceangame://wreck-shelf-echo-lens-route-review-2026-06-26",
    "oceangame://wreck-echo-readiness-gate-after-shell-hud-2026-06-26",
    "oceangame://wreck-echo-reward-choice-2026-06-26",
    "oceangame://vertical-slice-art-kit-screenshot-checklist-2026-06-26",
    "oceangame://resource-scan-affordance-review-after-pressure-shell-2026-06-26",
    "oceangame://resource-scan-source-art-target-decision-2026-06-26",
    "oceangame://expedition-day-five-seed-review-findings-2026-06-26",
    "oceangame://backlog-replenishment-playable-loop-polish-2026-06-26",
    "oceangame://backlog-replenishment-after-playable-loop-polish-2026-06-26",
    "oceangame://backlog-replenishment-after-playable-loop-closeout-2026-06-26",
    "oceangame://backlog-replenishment-after-vertical-slice-readability-2026-06-26",
    "oceangame://backlog-replenishment-after-vertical-slice-closeout-2026-06-26",
    "oceangame://backlog-replenishment-wreck-echo-prep-review-2026-06-26",
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
