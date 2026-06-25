# Shell Reef Route Review - 2026-06-25

Status: five-seed solo review complete for issue #77.

Reviewer: Codex

Method: deterministic headless scene probe plus checklist review against `docs/planning/SHELL_REEF_ROUTE_REVIEW.md`. This was not a blind validation pass. The probe used the current `Main.tscn` placement logic, `ProgressionState.advance_run()` seeds, and the active `SpawnSelection` helpers to record the first five consecutive expedition layouts.

Assumed upgrade state: current prototype progression capabilities available for review notes, with the route question focused on `Shell Reef` banking versus pushing deeper.

## Five-Seed Table

| Expedition | Seed | Pattern | Route Choice | Reef Interaction | Cargo Banked | Scans | Contacts | Turnaround | Unreadable Return Risks | Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 8919 | Deep reward route | Scan reef, bank reef shell, then consider lower deep glow route. | Shell pickup landed on reef shelf at `(350, 1090)`, so the reef has direct material value and a clear midwater stop. | 2 planned: Shell Fragments, then Glow Plankton if oxygen margin remains. | Shell Reef Shelf; optional Gulper Eel if warning route is approached. | 0 planned. | Lower deep glow at `(960, 1760)` or first predator warning. | Deep lure can pull attention away from the safe return read after the reef. | Expected extraction if player turns at warning; close extraction if they continue to glow. |
| 2 | 16838 | Cautious shallows | Use reef as safe midwater bank route after shallow kelp. | Shell pickup again landed on reef shelf at `(350, 1090)`, making the reef the natural banking midpoint. | 2-3 planned: Kelp Fiber, Shell Fragments, optional Glow Plankton. | Shell Reef Shelf. | 0 planned. | Full cargo or oxygen below comfortable return margin. | No major return-risk confusion observed from placement; this is the cleanest reef-banking seed. | Expected extraction. |
| 3 | 24757 | Deep reward route | Pass reef after scan and push toward deep shell/glow route. | Reef is a landmark and scan clue, but the shell pickup is deeper at `(720, 1340)`, so the reef does not itself pay out. | 1-2 planned depending on whether the player safely reaches shell/glow. | Shell Reef Shelf; optional Gulper Eel if player follows the upper warning route. | 0-1 risk if the player follows the upper gate too far. | Deep shell at `(720, 1340)` or upper warning route near deep glow at `(900, 1940)`. | This seed most clearly needs the reef return lane to stay visually separate from the predator warning lane. | Expected close extraction or failure if warning is ignored. |
| 4 | 32676 | Cautious shallows | Bank shallow/midwater cargo; reef is nearby but not mandatory. | Shell pickup is midwater at `(700, 1020)`, close enough that the reef can orient the route without hosting the reward. | 2-3 planned: Kelp Fiber, Shell Fragments, optional Glow Plankton. | Optional Shell Reef Shelf; the route works even if the scan is missed. | 0 planned. | Full cargo after midwater shell, or before deeper glow at `(930, 1600)`. | The reef may be treated as decoration if the scan marker is missed because the shell reward is not on the reef. | Expected extraction. |
| 5 | 40595 | Deep reward route | Push past reef toward deep shell and glow lure. | Reef is only a midwater landmark; shell at `(1040, 1240)` and glow at `(1110, 1840)` pull right/deep. | 1-2 planned if the player accepts deep-route risk. | Shell Reef Shelf; optional Gulper Eel. | 0-1 risk around upper deep reward route. | Deep shell or first predator warning before deep glow. | Deep reward lure dominates the decision; reef needs stronger return-read support on the way back. | Expected close extraction; possible oxygen failure if player overcommits. |

## Pass Signals

- The reef creates at least two different decisions across five seeds: direct midwater banking in seeds `8919` and `16838`, and pass-through landmark use in seeds `24757`, `32676`, and `40595`.
- At least one cautious run makes midwater banking sensible: seed `16838` is the clearest current pass case.
- At least one deep-reward run tempts a deeper route: seeds `24757` and `40595` pull the player past the reef toward deep shell/glow placements.
- Shell placement stays midwater and does not add extra pickup count; the reef contributes candidate positions but the single `Shell Fragments` pickup remains the limiting reward.
- The route decision changes between cautious and deep-reward patterns because deep-reward seeds pull kelp/shell/glow farther right/down while cautious seeds keep safer bankable cargo closer.
- Predator contact is not forced by the reef placement in the reviewed seeds; contact risk appears only if the player continues into the deep warning route.

## Fail Or Risk Signals

- In seed `32676`, the reef can read as decoration if the player misses or ignores the `Shell Reef Shelf` scan marker because the shell pickup is nearby but not on the reef.
- In seed `24757`, the deep route asks the player to use the reef as a return landmark while the predator warning lane is also competing for attention. This justifies a narrow return-readability pass rather than new mechanics.
- In seed `40595`, deep shell/glow placements may dominate the decision so strongly that the reef becomes a pass-through landmark unless the scan clue and return lane remain clear.
- No reviewed seed showed shell placement making upgrade costs trivial, but two reef-hosted shell seeds in the first five means future economy review should watch whether `Shell Fragments` become too reliable.

## Follow-Up Issue Recommendations

Use the existing queued issues rather than creating new issue titles from this review:

- #78 `Tune Shell Reef return readability after route review`
  - Evidence: seeds `24757` and `40595` need clearer return-lane separation after the player pushes past the reef.
- #79 `Tune deep-reward lure relative to Shell Reef route`
  - Evidence: seeds `24757` and `40595` can let the deep lure dominate the reef decision unless the lure and reef communicate different choices.
- #89 `Standardize scan target marker readability`
  - Evidence: seed `32676` depends on noticing the `Shell Reef Shelf` scan marker because the reef is more landmark than reward host.

No new broad polish issue is recommended from this review.
