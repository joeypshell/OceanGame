# Backlog Replenishment: Expedition Identity And Visual Follow-Through - 2026-06-26

Status: ordered issue queue to add after the current one-more-expedition motivation batch.

## Why This Batch Exists

The current open queue is already pushing the prototype toward day framing, region memory, first mystery planning, source-art replacement, and reusable visual structure. This next batch keeps momentum without jumping into broad new systems.

The goal is to make the same short dive feel more like a coherent game loop: the ocean changes by expedition day, the player recognizes places, scans and route choices produce small useful memories, and the visual language keeps moving away from raw placeholder geometry.

## Batch Guardrails

Do not use this batch to add:

- minimap or exact-coordinate tracking,
- field guide UI,
- calendar simulation or NPC management,
- weapons, predator health, harvesting, capture, or loot,
- new resource economies,
- broad procedural biome generation,
- new predator species,
- large final art packs,
- route checklist UI.

Every implementation should preserve existing movement, oxygen, cargo, scanning, save/load, pressure-lock, predator, and seeded expedition behavior unless the issue explicitly says otherwise.

## Ordered Issue Batch

1. #180 Add expedition day number to result and ready panel state.
2. #181 Add remembered-region result line from the deepest meaningful landmark reached.
3. #182 Add first-time discovery memory line for Thermal Vent, Shell Reef, Wreck, and Gulper scans.
4. #183 Add no-cargo useful-dive result copy when the player returns with scans only.
5. #184 Replace Kelp Fiber with a first source/export sprite.
6. #185 Replace Shell Fragments with a first source/export sprite.
7. #186 Add sprite-ready Lantern Fry visual slot and idle motion polish.
8. #187 Add sprite-ready Gulper Eel visual slot and state color polish.
9. #188 Extract resource pickup visuals into reusable child scenes.
10. #189 Extract Thermal Vent pocket visuals into a reusable scene.
11. #190 Add scan pulse visual helper for resource highlight feedback.
12. #191 Add low-oxygen visual warning treatment to player-facing HUD.
13. #192 Add cargo slot UI placeholders for player-facing cargo readability.
14. #193 Add surface result panel hierarchy review and copy tightening.
15. #194 Add scanner echo copy for Wreck Signal Cache repeat scans.
16. #195 Plan Echo Lens I as the next scanner curiosity upgrade.
17. #196 Add mystery signal planning notes to pressure-wreck and cache docs.
18. #197 Add five-seed expedition-day review checklist.
19. #198 Review visual asset slots after resource/landmark extraction.
20. #199 Replenish backlog after expedition identity and visual follow-through.

## Success Gate

This batch succeeds when:

- starting and ending a dive reads as an expedition day, not a raw reset,
- scan-only and route-choice dives still feel useful,
- at least two more resource or creature placeholders can accept real art through source/export conventions,
- repeated scan/mystery copy points toward future scanner progression without map UI,
- low oxygen, cargo, scan pulse, and result hierarchy are more readable at normal scale,
- extracted visuals reduce `Main.tscn` pressure without moving gameplay ownership,
- the next planning queue can be chosen from observed playtest and screenshot evidence.
