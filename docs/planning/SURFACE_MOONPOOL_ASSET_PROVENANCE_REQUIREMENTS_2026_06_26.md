# Surface Moonpool Asset Provenance Requirements - 2026-06-26

Status: planning/provenance artifact for issue #277.

## Purpose

Record source/export/provenance requirements for the surface moonpool and waterline asset slot.

The current asset is already wired as `surface_moonpool_waterline_v1.svg`; this note defines what must remain true for it and any future replacement.

## Required Files

Current asset set:

| Role | Path | Requirement |
| --- | --- | --- |
| Editable source | `assets/source/sprites/surface_moonpool_waterline_v1.svg` | Must remain editable and role-specific. |
| Runtime export | `assets/exports/sprites/surface_moonpool_waterline_v1.svg` | May be wired by Godot scene resources. |
| Provenance/license | `assets/licenses/surface_moonpool_waterline_v1.txt` | Must record origin, authoring basis, usage basis, and restrictions. |

Future replacements should keep the same three-part structure: source, export, provenance.

## Current Provenance Basis

The current asset is an in-repository SVG source-art pass made from simple generated vector shapes based on OceanGame's own existing boat, moonpool, and waterline readability direction.

It is not copied from:

- the uploaded visual target/reference image,
- external game screenshots,
- third-party sprite sheets,
- asset packs,
- unlicensed web images.

## Allowed Future Usage

Allowed:

- original vector redraws based on the project's own scene layout and readability needs,
- generated concept studies if the prompt, tool/method, date, and usage basis are recorded,
- paintovers or redraws that are materially new and documented,
- small source/export updates that preserve the gameplay role.

Not allowed:

- direct copy/tracing of uploaded reference art,
- copying commercial game art, screenshots, or UI,
- unlicensed third-party boat/moonpool/waterline sprites,
- unmanaged generated images with no prompt/provenance note,
- replacing gameplay nodes with art-only objects.

## Gameplay Ownership Guardrail

The moonpool/waterline asset may clarify the surface base visually, but it must not own gameplay behavior.

Preserve:

- `BaseZone` as the start/extraction gameplay area,
- player spawn/return behavior,
- collision/Area2D ownership,
- extraction rules,
- surface/result/upgrade/log panels,
- debug telemetry gating,
- save/load behavior.

The art slot lives under `SurfaceBaseArt/MoonpoolGuide` as visual support. `BaseZone` remains separate.

## Future Review Requirements

Any future moonpool/waterline replacement should include:

- source/export/provenance files,
- a short normal-scale review of ready, launch, and result states,
- confirmation that surface panels remain readable,
- confirmation that `BaseZone` and gameplay behavior are unchanged,
- Godot headless launch if scene wiring changes,
- logic tests if gameplay ownership changes,
- `git diff --check`.
