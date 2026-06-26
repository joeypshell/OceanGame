# Current Gameplay

This file describes implemented behavior. If gameplay, controls, runtime, deployment, or workflow changes, update this file before closing the related issue.

Near-term work is tracked in `docs/current/ROADMAP.md` and GitHub Issues.

## Product Behavior

- The project launches into a side-view vertical ocean slice with a placeholder controllable submersible.
- The selected direction is a 2D underwater roguelite where each dive is an expedition into alien ocean biomes.
- Intended first loop: dive from a safe base, gather resources, scan lifeforms, avoid or hunt predators, return before oxygen runs out, and craft upgrades that allow deeper future dives.
- Current world model: persistent geography with seeded expedition variation. The player should learn stable places, depth bands, safe return orientation, major gates, and upgrade-locked route promises while each expedition can vary resource placement, route/reward cluster pattern, and predator route selection from authored candidates.
- Full procedural biome generation, complete ocean rerolls, and real-calendar daily challenge rules are not implemented in the current prototype.
- Current controls: move with WASD or arrow keys, and press Spacebar for `Burst Thruster` during active dives.
- Extraction controls: return to the safe base and press E or Enter to end the dive successfully.
- Test reset: press R after extraction or oxygen failure to restart the prototype dive.
- Input is routed through Godot actions: `move_left`, `move_right`, `move_up`, `move_down`, `interact`, `restart_dive`, `scan`, and `burst_thruster`. F3 toggles development telemetry visibility.
- Current movement uses acceleration, drag, and a bounded vertical dive area so the placeholder submersible cannot leave the prototype space.
- The first scene starts the player at a visible surface boat/shallow lab base near the top of the water column.
- The camera follows the player through a vertical descent with limits that keep the side-view dive space readable.
- Oxygen drains at `0.95` oxygen per second during an active dive. Extracting before oxygen reaches zero succeeds; reaching zero shows a placeholder failure result with cargo loss text.
- Low oxygen changes presentation only: below 25 percent, the HUD shows a low-oxygen warning; below 10 percent, the oxygen and base-direction HUD pulse with critical return feedback.
- Low-oxygen feedback does not add ascent drain, decompression, depth-based oxygen penalties, or hidden oxygen costs.
- `Burst Thruster` is a prototype non-lethal active tool mapped to Spacebar. It applies a short burst in the current movement direction, or the last facing/movement direction if no movement input is held.
- `Burst Thruster` costs 4 oxygen, has a 4-second cooldown, and cannot activate when the cost would immediately deplete oxygen.
- The HUD prompt shows whether `Burst Thruster` is ready and its oxygen cost or current cooldown. Status text reports successful activation, cooldown denial, and low-oxygen denial.
- `Burst Thruster` does not damage, stun, harvest, or bypass predators, resources, pressure locks, or progression gates.
- When `Decoy Pulse I` is relevant, the HUD prompt separately reports whether the pulse is upgrade-locked, ready on `Gulper Eel` re-scan, or already spent for the expedition. Gulper Eel scan status text reports unavailable, spent, and already-spent states, and the predator hint shifts to a temporary green decoy color while distracted.
- Current-dive state lives in `DiveSession`: oxygen, cargo, has-left-base, current depth, and dive result.
- Dives begin from an `Expedition Ready` panel. Press E or Enter to begin oxygen drain and active dive play. The panel includes the current presentation-only expedition condition, plus one concise goal line that points to the next useful upgrade purchase, missing banked resources, scan prerequisite such as `Thermal Vent` or `Wreck Signal Cache`, or the `Shell Reef` midwater route objective once configured upgrade goals are complete.
- Extraction and oxygen failure show a run result panel summarizing banked cargo, carried-cargo loss, one concise route-choice callout, durable upgrade progress, discoveries recorded or kept, and best depth.
- Extraction and oxygen failure result panels default to compact player-facing summaries. Development telemetry is hidden by default, but F3 or the exported `show_debug_telemetry` flag exposes result, seed, cluster pattern, expedition condition display/id, predator route, cargo collected, scans, predator contacts, oxygen at result, and failure cause.
- The HUD keeps a compact session-only `Recent Expeditions` log for the last three completed dives. Each entry shows result, banked cargo count, scans, predator contacts, and best depth; seed and cluster pattern appear only while debug telemetry is enabled.
- After a successful extraction, the surface HUD uses compact `Result`, `Upgrades`, and `Log` views so the run result, upgrade bay, and recent-expedition log do not all compete for attention. Press Left/Right to cycle these surface views.
- The `Result` view keeps the extraction summary in focus, the `Upgrades` view focuses the data-backed upgrade bay with Up/Down selection and E or Enter purchase, and the `Log` view shows the recent expedition history in the run panel.
- Surface states are panel-led: ready/result/failure screens hide loose title/instruction labels and operational dive HUD rows such as oxygen, depth, base distance, cargo, scan target, discoveries, and status so they do not overlap the ready/result panels. The ready panel owns movement, start, and reset instructions.
- Active dives show only the compact operational HUD: oxygen, depth, base direction, one-line cargo, compact discovery count, and a bounded dive info panel containing current scan target, short prompt, and status text. Banked resources, upgrade details, recent expedition history, and full discovery lore remain out of the loose dive HUD.
- Each expedition has a session number and deterministic seed. The raw seed is visible only when development telemetry is enabled.
- Each expedition now selects a deterministic presentation-only expedition condition from the current seed. The condition has an id, display name, short briefing line, and tags, but it does not yet change spawns, predator routes, oxygen, scan range, pressure gates, cargo, resources, or upgrades.
- Each expedition selects a seeded resource cluster pattern: `Cautious shallows` or `Deep reward route`. The raw pattern label is visible only when development telemetry is enabled.
- Pressing R after a result prepares the next seeded expedition, advancing the session number and seed while preserving banked resources, upgrades, discoveries, and best depth.
- Session progression lives in `ProgressionState`: banked resources, purchased upgrades, scan discoveries, and best depth reached.
- Long-term progression automatically loads from one local prototype save slot at launch and saves after extraction, oxygen failure, scanning, and upgrade purchase.
- The prototype save uses schema version `1`. It includes `save_version`, banked resources keyed by resource id, purchased upgrades keyed by upgrade id, scan discoveries keyed by discovery id, and best depth reached.
- Scan discovery entries still keep a small display snapshot for the current practical scan-result UI, but progression identity should continue to come from discovery ids and upgrade ids rather than copied display text.
- Missing `save_version` saves are treated as legacy version `0` and migrate by loading the known progression fields. Current version `1` loads the same known fields directly. Unknown newer versions warn and load known fields only so prototype progress is not discarded.
- The prototype save does not restore active oxygen, current cargo, active run state, temporary effects, current expedition number, current expedition seed, or whether the one-use `Decoy Pulse I` has been spent during the active expedition.
- Pressing `F9` resets the local prototype save from inside the running game. It clears banked resources, purchased upgrades, scan discoveries, best depth, and the save file, then returns the scene to a clean Expedition 1 ready state.
- Use `F9` before first-run playtests when the tester should experience the prototype without previously owned upgrades, banked resources, scan discoveries, or best-depth history. Relaunching the game without `F9` should keep durable progression but still start from a fresh ready expedition rather than an in-progress dive.
- Extraction only succeeds after the player has left the base and returned.
- The player starts with three cargo slots. Resource pickups fill cargo during a dive and cost 1 oxygen to collect.
- Starter resources are placed from authored candidate points using the current run seed: `Kelp Fiber` stays shallow, `Shell Fragments` stays midwater, and `Glow Plankton` stays deep. The `Thermal Vent` pocket contributes vent-adjacent `Glow Plankton` candidates for existing seeded selection rather than adding extra active resource pickups.
- Starter resource candidate points use typed `SpawnPoint` nodes with category, target id, depth band, and position data so later hazards, creatures, discoveries, and resource clusters can use the same placement model.
- The main scene includes passive `LandmarkMetadata` nodes for Surface Base, Shell Reef, Thermal Vent Field, Wreck Shelf, Pressure-Locked Research Wreck, and Gulper Route. These describe persistent place identity for future planning/review but do not change current gameplay behavior.
- `Cautious shallows` clusters keep the first three starter resources closer to safer shallow/midwater banking routes, while `Deep reward route` clusters pull the deeper `Glow Plankton` toward the predator-controlled route.
- `Deep reward route` runs show a faint glow/current lure with a compact reward core below the `Shell Reef` decision band, hinting at valuable deep `Glow Plankton` after the player can read the safer midwater bank route.
- A compact authored `Shell Reef` pocket sits in the midwater band as a pale shell/coral route landmark. It is lightweight scene geometry with typed `Shell Fragments` spawn candidates, but it does not add extra pickup count, collision, a new resource tier, a new predator, or procedural biome behavior.
- The `Shell Reef Shelf` is scannable as an environmental clue. First-time scan records that the reef is a safer midwater banking route before deeper pressure and predator risk; repeat scan remains free and refreshes the compact route clue.
- The `Gulper Eel` predator route is selected from authored creature route spawn points by expedition seed and cluster pattern. Cautious patterns choose a deep left or right gate, while deep-reward patterns choose an upper or lower predator gate near the deeper reward route.
- The predator warning current/marker moves with the selected route, and result telemetry records the selected predator route id for playtest comparison.
- A visible `Pressure-Locked Research Wreck` sits behind a clearer locked-route pressure gate near the lower midwater/deep transition. The gate safely denies entry until `Pressure Seal I` is owned, without adding hidden oxygen damage.
- The wreck has an outside scan target, `Pressure-Locked Research Wreck`, that can be scanned before entry. Scanning it records a practical clue to buy `Pressure Seal I` at the surface and then return; it also reveals a subdued future-cache signal so the cache reads as a later payoff, not an immediate open path.
- After `Pressure Seal I` is owned, the wreck alcove can be reached and the inside `Wreck Signal Cache` can be scanned as a practical progression reward pointing toward a future scanner improvement.
- Extraction banks carried resources into session progression. Oxygen failure discards carried resources but keeps banked resources.
- After extraction, the surface upgrade bay view shows data-backed upgrade entries with cost, one-line missing resources, missing discovery if any, and explicit `State:` labels for owned, available, scan-locked, and missing-resource upgrades. Extraction feedback also calls out newly ready upgrades when banked cargo completes a cost.
- The upgrade bay supports selecting configured upgrades with Up/Down while extracted. The current prototype has six configured upgrades: `Oxygen Tank I`, `Pressure Seal I`, `Signal Lens I`, `Cargo Rack I`, `Predator Warning I`, and `Decoy Pulse I`.
- `Oxygen Tank I` can be bought from the upgrade panel with banked `Kelp Fiber x2`, `Shell Fragments x1`, and `Glow Plankton x1`.
- `Oxygen Tank I` raises future dive max oxygen from 30 to 40 during the current session.
- `Pressure Seal I` requires the `Thermal Vent` discovery plus banked `Kelp Fiber x1`, `Shell Fragments x2`, and `Glow Plankton x2`.
- `Pressure Seal I` opens the first pressure-locked research wreck route by disabling the pressure-boundary denial and changing the shimmer feedback to show the route is open.
- `Signal Lens I` requires the `Wreck Signal Cache` discovery plus banked `Kelp Fiber x1`, `Shell Fragments x2`, and `Glow Plankton x2`.
- `Signal Lens I` makes repeat resource scans add a short local signal hint toward the nearest matching visible uncollected deposit in the current expedition. If no matching deposit is visible, the HUD says the signal is quiet.
- `Cargo Rack I` costs banked `Kelp Fiber x2`, `Shell Fragments x2`, and `Glow Plankton x1`.
- `Cargo Rack I` raises future dive cargo capacity from 3 to 4 without changing extraction banking or the rule that oxygen failure loses all carried cargo.
- `Predator Warning I` requires the `Gulper Eel` discovery plus banked `Kelp Fiber x1`, `Shell Fragments x2`, and `Glow Plankton x1`.
- `Predator Warning I` makes existing predator warning feedback begin farther from the `Gulper Eel` without changing patrol, chase/contact radius, oxygen loss, knockback, or seeded route selection.
- `Decoy Pulse I` requires the `Gulper Eel` discovery, ownership of `Predator Warning I`, and banked `Kelp Fiber x1`, `Shell Fragments x1`, and `Glow Plankton x2`. After purchase, re-scanning the `Gulper Eel` with F spends one decoy pulse for the current expedition, briefly pulling the predator away from the player to create a temporary route-timing window. The effect does not damage, stun-lock, harvest, trap, remove, or permanently control the predator, and it does not change seeded route selection, pressure locks, extraction, cargo failure rules, or `Burst Thruster` behavior.
- Scan with F. The HUD shows the current scan target name plus compact metadata such as `new resource`, `known creature`, `new environment`, or `known wreck signal`; the selected target is highlighted. Non-resource scan targets use a compact pale diamond marker with focus brackets when selected, while resource pickups keep their material silhouettes and selected-target tint. Targeting chooses the nearest valid scan target, with stable id-based tie-breaking when distances match.
- First-time scans cost 2 oxygen and record session-persistent discoveries. Re-scanning an already discovered target does not spend oxygen, but still refreshes that discovery's practical effect if it has one.
- Current planning recommendation keeps repeat tactical scans free for this prototype; see `docs/planning/REPEAT_SCAN_COST_RECOMMENDATION.md`.
- First-time scan status text includes a concise next action. Resource scans point the player to collect the resource and return to base to bank cargo, while non-resource scans point toward the revealed clue or a safe return.
- Resource pickups are scannable before collection. Resource scans record the resource depth band, upgrade use, and whether more of that material is needed for `Oxygen Tank I`; they also temporarily highlight matching visible resource deposits in the current expedition.
- `Lantern Fry` is a passive scannable creature near the deeper `Glow Plankton`; scanning it temporarily pulses nearby `Glow Plankton` and suggests following the pulse if oxygen allows.
- A scannable `Thermal Vent` sits inside a small authored warm-current pocket with vent wash, cracked shelf, bubble strings, and a subtle current ribbon. Scanning it still reveals a soft optional-current hint and hidden `Glow Plankton` cluster, but the status text frames the route as optional if oxygen allows and reminds the player that the discovery is useful pressure-seal knowledge to bank at the surface.
- A `Gulper Eel` predator patrols a deep route to a valuable `Glow Plankton` pickup. The route has a red warning current, ribs, eye, and compact hazard badge, and the patrol hint becomes more urgent as the player approaches. Getting too close triggers a brief chase; contact costs 5 oxygen, knocks the player back, and briefly disrupts movement.
- The `Gulper Eel` is scannable as a non-combat observation target. First-time scan records a durable behavior clue about warning currents, patrol hints, oxygen risk, and route timing; repeat scans remain free and refresh the predator-route warning text without damaging, slowing, stunning, repelling, harvesting, or controlling the predator.
- The HUD shows current depth, best depth reached, and base direction/distance so the return route remains understandable while diving.
- The scene uses surface light rays, subtle depth transition bands, a safe-base return column with repeated return ribs, a compact return beacon near the surface lane, a beaconed surface boat/lab, shallow kelp silhouettes, a midwater shelf, stronger Shell Reef landmark wash/shell silhouettes and return-current shapes, a warmer Thermal Vent landmark silhouette, subdued cyan/green route-current hints, deep pressure haze, a quieter deeper glow hint, firm blue pressure-gate bars/shimmer, a compact `LOCKED`/`OPEN` pressure badge, subdued pressure-wreck signal glow, and red predator warning ribs/current/hazard badge to communicate depth bands, safe return, blocked opportunity, and route danger without adding new mechanics. Safe-return shapes have higher visual priority than optional route and reward hints, and locked pressure routes are visually firmer than current hints.

## Runtime / Setup

- Engine: Godot 4.7 with GDScript.
- Primary target: local desktop.
- Secondary target: optional web demo. The project uses Godot's Compatibility renderer so web export remains plausible; avoid Godot C# unless the web target is intentionally abandoned.
- Launch locally from the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64.exe" --path .
```

- Headless launch smoke from the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

- Source layout:
  - `project.godot`: Godot project configuration.
  - `scenes/Main.tscn`: first scene.
  - `scenes/Player.tscn`: placeholder submersible scene.
  - `scripts/main.gd`: scene orchestration, HUD updates, expedition flow, and scene-specific scan/upgrade effects.
  - `scripts/dive_session.gd`: current-dive oxygen, cargo, depth, extraction, and failure state.
  - `scripts/progression_state.gd`: session-persistent resources, upgrades, discoveries, best depth, and save schema migration.
  - `scripts/player.gd`: basic placeholder player movement.
  - `scripts/resource_definition.gd`: typed resource data definition for upcoming pickup/resource work.
  - `scripts/resource_pickup.gd`: pickup nodes that emit collection events and reset between dives.
  - `scripts/scannable.gd`: simple scannable targets, including passive moving creatures.
  - `scripts/spawn_point.gd`: typed candidate placement points for seeded resource and creature route variation.
  - `scripts/spawn_selection.gd`: deterministic helper for seed-to-pattern selection, spawn positions, and authored route dictionaries.
  - `scripts/expedition_condition.gd`: deterministic presentation data for seeded expedition-day conditions.
  - `scripts/landmark_metadata.gd`: passive authored metadata for persistent place identity.
  - `scripts/scan_target_resolver.gd`: deterministic helper for scan target validity, identity, display fields, and nearest-target tie-breaking.
  - `scripts/predator.gd`: simple patrol, detection, chase, and contact behavior.
  - `scripts/upgrade_definition.gd`: small data model for upgrade definitions and generic purchase handling.
  - `scripts/upgrade_purchase.gd`: generic upgrade prerequisite and purchase gate helper.
  - `tests/logic_tests.gd`: headless deterministic checks for cargo, extraction, oxygen failure, upgrades, save/load, seeds, spawn matching, and discovery prerequisites.
  - `resources/*.tres`: starter resource definitions.
  - `resources/upgrades/*.tres`: upgrade definitions.
- GitHub Actions:
  - `.github/workflows/godot-smoke.yml`: runs a Godot headless launch smoke check, deterministic logic tests, and `git diff --check`.
- Do not commit `.godot/`, `.import/`, `*.import`, local editor cache, build output, secrets, or export artifacts.

## Verification

Preferred checks:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
git diff --check
```

Manual smoke:

- Launch the project and confirm the first scene runs.
- Confirm the expedition starts at the `Expedition Ready` panel and does not begin active oxygen pressure until E or Enter is pressed.
- For clean first-run checks, press `F9` on the ready screen and confirm the ready panel returns to `Expedition 1`, oxygen is back to the base starting value, banked resources/upgrades/discoveries are cleared, and best depth is reset.
- Confirm the ready-panel goal keeps upgrade resource and scan-prerequisite goals ahead of the `Shell Reef` route objective.
- Confirm each restarted expedition advances the session number and seed while persistent progression remains.
- Relaunch the project after banking resources, buying an upgrade, or recording a discovery, and confirm long-term progression reloads while active cargo and current-dive state do not.
- Relaunch the project after pressing `F9` and confirm the clean progression state persists across launch.
- Confirm restarted expeditions vary the starter resource positions while keeping `Kelp Fiber` shallow, `Shell Fragments` midwater, and `Glow Plankton` deep.
- Confirm restarted expeditions alternate between `Cautious shallows` and `Deep reward route` cluster patterns, and that the deep reward pattern tempts a route near the predator patrol.
- Confirm restarted expeditions vary the `Gulper Eel` route and move the warning current/marker with it without blocking the safe return path.
- Confirm the deep-reward lure appears only on `Deep reward route` expeditions, begins below the `Shell Reef` decision band, and preserves surface return readability.
- Confirm the `Shell Reef` pocket is readable as a midwater landmark, leaves open route gaps, can host the existing single `Shell Fragments` pickup, and uses the return-current shapes to point back toward the surface/base path without blocking it.
- Scan the `Shell Reef Shelf`, confirm discovery/result/log text records a safer midwater bank route clue, then repeat scan and confirm no oxygen is spent.
- After extraction, use Left/Right to cycle the compact surface views and confirm `Result`, `Upgrades`, and `Log` keep their text readable; confirm Up/Down and E or Enter still select and purchase upgrades only while the `Upgrades` view is active.
- Move or edit a `StarterResourceCandidates` spawn point in the scene and confirm seeded resource placement follows that typed definition.
- Move the placeholder submersible with WASD or arrow keys and confirm it accelerates, slows under drag, turns toward velocity, dives downward from the surface, and stays inside the test bounds.
- During an active dive, press Spacebar and confirm `Burst Thruster` moves the sub in the held movement direction, spends 4 oxygen, starts a 4-second cooldown, and updates HUD/status feedback.
- Try Spacebar again during cooldown and confirm no oxygen is spent and the status shows remaining cooldown.
- Try Spacebar with 4 or less oxygen and confirm it does not activate or immediately fail the dive.
- Use Spacebar near the predator route and near the pressure-locked wreck; confirm it can reposition the player but does not damage predators or bypass the pressure lock.
- Return to the safe base, press E or Enter, and confirm the HUD shows a successful extraction result.
- Confirm extraction and oxygen failure both show result summaries before restarting.
- Confirm extraction and oxygen failure summaries hide raw telemetry by default, then press F3 and confirm seed, pattern, condition display/id, predator route, cargo, scans, predator contacts, oxygen result, and failure cause appear for playtesting.
- Confirm extraction and oxygen failure summaries include one compact `Route choice:` line, such as reef banking, Thermal Vent clue progress, deep glow push, predator-route pressure, or pressure-wreck progress, without turning the panel into a checklist.
- Complete or fail four expeditions and confirm the `Recent Expeditions` log shows only the latest three results, with seed and cluster pattern hidden until debug telemetry is enabled.
- Approach multiple nearby scan targets and confirm the HUD names one selected target with a visible highlight, then confirm the selected target remains deterministic until distance changes.
- Approach a new resource, already discovered resource, creature, environmental scan target, and wreck signal; confirm the scan target HUD metadata stays compact and accurate, non-resource scan markers remain readable, and resource pickups still read as cargo first.
- Confirm immediate extraction at the starting base does not succeed until the player leaves and returns.
- Confirm oxygen decreases during the active dive.
- Confirm low oxygen shows warning feedback below 25 percent and stronger base-direction/oxygen emphasis below 10 percent without changing oxygen costs.
- Collect resources, confirm cargo fills up to three slots, extract, and confirm resources move into the banked list.
- After extraction, confirm the surface upgrade bay shows a selected upgrade entry, cost, one-line missing requirements, owned/available/locked/missing-resource state, and feedback.
- Press Up/Down in the upgrade bay and confirm selection moves between `Oxygen Tank I` and `Pressure Seal I`.
- Attempt to buy `Oxygen Tank I` without enough resources and confirm the upgrade panel gives clear feedback.
- Bank the required resources, buy `Oxygen Tank I` from the upgrade panel after extraction, restart, and confirm max oxygen is 40.
- Confirm `Pressure Seal I` is locked before scanning `Thermal Vent`, available after the discovery plus required resources, and owned after purchase.
- After buying `Pressure Seal I`, return to the pressure-locked wreck and confirm the shimmer route is open and the inside `Wreck Signal Cache` can be scanned.
- Confirm `Signal Lens I` is locked before scanning `Wreck Signal Cache`, available after the discovery plus required resources, and owned after purchase.
- Buy `Cargo Rack I`, restart a dive, and confirm the HUD starts at `Cargo: 0 / 4`.
- After buying `Cargo Rack I`, collect four resources, extract, and confirm all four bank correctly.
- After buying `Cargo Rack I`, fail with carried cargo and confirm all carried cargo is still lost.
- Confirm `Predator Warning I` is locked before scanning `Gulper Eel`, available after the discovery plus required resources, and owned after purchase.
- After buying `Predator Warning I`, approach the `Gulper Eel` route and confirm warning feedback begins farther away while contact remains possible if the warning is ignored.
- Confirm `Decoy Pulse I` is locked before scanning `Gulper Eel`, remains locked until `Predator Warning I` is owned, becomes available with its required resources afterward, and can be spent once per expedition by re-scanning the `Gulper Eel`. Confirm the predator is pulled away briefly, contact remains possible after the window or on mistiming, and pressure locks, extraction, cargo failure, seeded route selection, and `Burst Thruster` are unchanged.
- Scan `Lantern Fry` with F, confirm oxygen decreases, discovery text appears, and `Glow Plankton` pulses.
- Scan `Thermal Vent` with F, confirm oxygen decreases, discovery text appears, and the low-opacity current hint plus hidden `Glow Plankton` appear without reading like a guaranteed safe path. Re-scan it and confirm the repeat text refreshes the warm-current clue while keeping the glow route optional.
- Approach the pressure gate near the research wreck without `Pressure Seal I` and confirm entry is denied safely with clear feedback that says to buy the upgrade at the surface and return.
- Scan the outside `Pressure-Locked Research Wreck` target and confirm the future-cache signal appears without looking like an immediately open path or disrupting extraction/failure flow.
- Scan a resource pickup with F, confirm oxygen decreases, discovery text records depth band/upgrade use/material need, and matching visible deposits highlight for several seconds.
- Start a fresh expedition, scan the first nearby resource, and confirm the status text says to collect it and return to base to bank cargo.
- After buying `Signal Lens I`, re-scan a discovered resource and confirm status text points toward another matching visible uncollected deposit or says the signal is quiet.
- Re-scan an already discovered resource and confirm no oxygen is spent while the matching-deposit highlight refreshes.
- Approach the deep `Gulper Eel`, confirm the warning current/marker and patrol hint communicate danger before contact, then confirm contact causes oxygen loss plus knockback without instant failure.
- Scan the `Gulper Eel`, confirm the discovery text is recorded, repeat scan stays free, and patrol/chase/contact behavior still works unchanged.
- Collect resources, fail by oxygen depletion, restart, and confirm carried resources were lost while banked resources remain.
- Confirm the HUD depth increases while diving and that the base indicator points back toward the surface base.
- Confirm the scene communicates shallow, midwater, and deep areas through color, transition bands, landmarks, and resource placement. Confirm the `Thermal Vent` pocket reads as a warm optional clue route without obscuring Shell Reef banking, pressure-gate feedback, or safe-return language.
- Let oxygen reach zero and confirm the HUD shows a failure result.
- After first dive loop: start a dive, collect or scan something, return to base, and confirm the result is recorded.

## Vertical Slice Playtest Notes

- First-loop validation: the surface base is visible at start, the HUD labels depth and base direction, and the first shallow resource is visible before the player commits to a deeper route.
- Risk validation: a cautious dive can bank shallow/midwater cargo, a deeper dive can pursue `Glow Plankton`, and the `Gulper Eel` route can turn a deep reward attempt into a close oxygen return or failure.
- Upgrade validation: because cargo has three slots and `Oxygen Tank I` costs four total resources, the first upgrade requires at least two successful banking dives; after purchase, the 40-oxygen run gives room for an extra scan, pickup, or predator recovery before returning.
