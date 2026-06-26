# Source-Art Provenance Checklist - 2026-06-26

Status: reusable checklist for issue #311.

## Purpose

Use this checklist before committing any future sprite/source-art batch.

The checklist is intentionally about source discipline and readability evidence. It does not add runtime assets by itself and does not approve broad art overhaul scope.

## Batch Definition

A sprite/source-art batch may be:

- one source/export/provenance asset,
- a small matched set for one visual role,
- or a narrow replacement pass for one existing scene slot.

Do not mix unrelated roles in the same batch. A pressure wreck shell, HUD skin, creature state, resource set, and background pass should be separate issues unless a later milestone explicitly approves a cohesive art-kit integration pass.

## Required Files

For each committed asset or asset set, confirm:

- editable source file exists under `assets/source/`,
- runtime export exists under `assets/exports/` only when the Godot project uses it,
- provenance note exists under `assets/licenses/`,
- filenames are role-first and stable enough to survive iteration,
- generated Godot import caches are not intentionally added as new source-of-truth files,
- file names match across source, export, and provenance notes where practical.

Current naming pattern:

```text
<role>_<subject>_<variant>_<stage>.<ext>
```

Examples:

```text
resource_glow_plankton_sprite_v1.svg
creature_gulper_eel_sprite_v1.svg
surface_moonpool_waterline_v1.svg
```

## Provenance Note

Each provenance note should cover the fields used by `assets/licenses/README.md`:

```text
Asset path:
Source path:
Creator or tool:
License or usage basis:
Source URL:
Date added:
Prompt summary, if generated:
Edited after generation:
Intended use: prototype / production candidate
Restrictions:
```

Generated assets should also record:

- generation tool if known,
- prompt summary rather than a giant prompt dump,
- whether the export was edited or traced afterward,
- whether the result is a concept study, prototype sprite, or production candidate.

If provenance is unclear, do not commit the asset.

## Scene Wiring Check

Before wiring art into a scene, confirm:

- the asset replaces or skins an existing visual role,
- gameplay nodes, collision, spawn points, scan targets, route behavior, and save/progression ownership remain unchanged unless the issue explicitly authorizes behavior changes,
- fallback geometry is kept, hidden, or subdued intentionally,
- scan markers, pressure gates, predator warnings, resources, safe-return cues, and HUD states remain visually distinct,
- source art does not become a hidden objective marker, minimap, route arrow, or checklist cue by accident.

## Fallback Behavior

When source art is wired:

- keep fallback shapes visible if they still carry clearer gameplay meaning,
- subdue fallback shapes only after normal-scale review shows the source asset carries the read,
- remove fallback shapes only when the scene no longer needs them and the issue explicitly approves cleanup,
- do not leave duplicate bright reads that make one object look like two separate gameplay targets.

## Verification Checklist

Every source-art batch should record the relevant verification:

- `git diff --check`,
- Godot headless launch for wired runtime assets,
- logic tests if scene contracts, helper code, scan behavior, route behavior, or state ownership changes,
- MCP context self-test if docs or context resources change,
- normal-scale screenshot/manual review when readability is the point of the issue.

## Review Questions

Before closing a source-art issue, answer:

- What gameplay or readability role does this asset serve?
- Which existing placeholder or scene slot does it replace or support?
- What still owns gameplay truth?
- Is the asset brighter or more important-looking than it should be?
- Are source, export, and provenance all present?
- Is the fallback treatment intentional?
- Did the issue avoid broad art-kit, new mechanic, route, map, field-guide, or checklist scope?

## Non-Goals

This checklist does not authorize:

- unlicensed asset drops,
- broad visual-overhaul batches,
- new gameplay systems,
- new route or biome implementation,
- hidden objective markers,
- exact locators,
- minimaps,
- field-guide UI,
- quest logs,
- committing unknown provenance files.
