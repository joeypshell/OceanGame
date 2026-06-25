# Predator Countermeasure I

Status: planning complete. Recommended future implementation issue title: `Add Decoy Pulse I predator countermeasure`.

## Purpose

`Predator Countermeasure I` should be the first true non-lethal tool for crossing or recovering from the `Gulper Eel` route after observation and warning readability have been established.

The countermeasure should not make the predator harmless. It should create a short decision window where the player can spend resources or oxygen preparation to change a risky route choice.

## Candidate Countermeasures

### Decoy Pulse

Effect: trigger a short-lived pulse that attracts or distracts the `Gulper Eel` away from the player for a brief timing window.

Strengths:

- Feels like ecological preparation instead of combat.
- Creates a clear moment-to-moment choice: spend the decoy now, wait, or retreat.
- Can use `Gulper Eel` observation data and `Predator Warning I` as a logical prerequisite.
- Does not require health bars, damage, stun, harvesting, or a broad tool wheel.

Risks:

- Too much duration can trivialize predator risk.
- Needs very clear feedback so players understand it is temporary.
- Could overlap with `Burst Thruster` unless the decoy is about route timing rather than emergency movement.

### Route Tag

Effect: after observing the predator, tag the current predator patrol route or warning lane more clearly for the current expedition.

Strengths:

- Stays close to route reading and seeded expedition structure.
- Low risk of becoming combat.
- Could help with planning before the player commits to deep rewards.

Risks:

- Too passive to feel like the first true countermeasure.
- Can drift toward minimap or route overlay behavior.
- Overlaps the purpose of `Predator Warning I` unless it adds a distinct decision.

### Short Repel Burst

Effect: push the predator away briefly if it enters a close danger radius.

Strengths:

- Easy for players to understand as an emergency defense.
- Strongly reduces one mistake without killing or harvesting the predator.

Risks:

- Can feel like a stun or weapon even if it deals no damage.
- May erase the value of reading warning currents.
- Competes directly with `Burst Thruster` as the mistake-recovery tool.

### Scanner-Assisted Timing Window

Effect: scanning or re-scanning the predator briefly highlights a safer crossing moment or weakens warning uncertainty.

Strengths:

- Reinforces the research fantasy.
- Builds on scanner systems instead of adding tool UI.
- Keeps the predator behavior intact.

Risks:

- Could become text-heavy or tutorial-like.
- Less satisfying as a countermeasure because it may not change route pressure enough.
- Overlaps `Signal Lens I` and scan-target readability work.

## Recommendation

Implement `Decoy Pulse` first.

Concrete future implementation issue title: `Add Decoy Pulse I predator countermeasure`.

The first version should be narrow:

- one non-lethal predator-preparation upgrade,
- one short-use decoy pulse against the current `Gulper Eel`,
- one clear cooldown or one-use-per-expedition limit,
- no predator damage, stun, harvest, trap capture, health, or route removal.

## Unlock Requirements

Recommended gate:

- Required discovery: `gulper_eel`.
- Recommended prerequisite: own `Predator Warning I`, so the player first learns to read danger before actively manipulating it.
- Purchase through the existing upgrade bay.

Cost direction:

- Use existing starter resources only.
- Bias toward `Glow Plankton` because the countermeasure is about contested deep-route preparation.
- Keep `Shell Fragments` present but avoid making the shell economy feel more repetitive after `Resource Economy Tuning I`.

Candidate cost:

- `Glow Plankton x2`
- `Kelp Fiber x1`
- `Shell Fragments x1`

Do not add decoy ammo crafting, separate charges as inventory items, or a new energy resource in the first implementation.

## Expected Player Decision

The player should ask:

- Is this deep route worth spending my decoy window?
- Should I use the decoy before crossing, save it for a bad patrol timing, or return with cargo?
- Can I combine warning readability, route observation, and `Burst Thruster` oxygen cost without overcommitting?
- If the decoy is already spent, should I still push deeper?

The tool should make the route more playable, not automatically safe.

## Non-Lethal Constraints

Do not add:

- weapons,
- predator damage,
- stun-locks,
- health bars,
- predator harvesting,
- hunting contracts,
- traps-as-combat,
- permanent route removal,
- new predator types for content volume,
- broad tool wheels,
- minimap-style predator control.

If the decoy redirects the predator, the effect must be temporary and clearly communicated as a distraction, not domination or capture.

## Relationship To Existing Tools

- `Predator Warning I` improves early warning and should remain useful even when the decoy is owned.
- `Burst Thruster` is oxygen-cost movement recovery; it should not trigger or replace the decoy.
- `Signal Lens I` remains resource-scan utility, not predator control.
- Pressure locks, extraction, cargo loss, seeded route selection, predator contact oxygen loss, and knockback should remain intact.

## Verification Criteria For Future Implementation

- The upgrade stays locked until the required discovery/prerequisite is satisfied.
- Buying the upgrade uses existing banked resources and upgrade bay behavior.
- Activating the decoy creates one short, readable route-timing window.
- Predator contact remains possible if the player mistimes the route or ignores the warning.
- The decoy does not damage, stun-lock, harvest, trap, or remove the predator.
- The countermeasure does not change seeded route selection, pressure locks, extraction, or cargo failure rules.
