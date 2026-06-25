# Repeat Tactical Scan Cost Recommendation

Date: 2026-06-25

## Context

The current scanner rule is:

- First-time scans cost oxygen and create a persistent discovery.
- Re-scanning an already discovered target costs no oxygen.
- Repeat scans can refresh practical effects, such as pulsing nearby `Glow Plankton`, revealing route hints, or highlighting matching resource deposits.

This is provisional, but it is now good enough to evaluate because practical scan effects exist.

## Options Reviewed

### Keep Repeat Tactical Scans Free

Pros:

- Easy to explain: new information costs oxygen once; remembered information can be checked again.
- Supports player learning while the prototype is still teaching resource identity, route hints, and predator risk.
- Repeat scanning still has a soft cost because active dives continue draining oxygen while the player stops or turns to scan.
- Avoids punishing players for rechecking information they have already earned.

Cons:

- Could become spammy if later scanner effects become stronger, longer range, or combat-adjacent.
- May undercut tension if a future scan effect reveals too much route safety with no decision cost.

### Smaller Repeat Oxygen Cost

Pros:

- Keeps every scanner use attached to oxygen pressure.
- Simple to implement and tune.

Cons:

- Creates two scan costs to explain during an already information-heavy first loop.
- Risks making useful rechecks feel like a tax rather than a tactical choice.
- Could make low-oxygen returns more frustrating when players use a repeat scan to recover orientation.

### Cooldown

Pros:

- Prevents spam without adding another resource.
- Keeps the scanner free while preserving pacing.

Cons:

- Adds invisible timing rules unless the HUD grows cooldown feedback.
- Can feel arbitrary in a prototype where scan effects are mostly readability aids.
- Does not create a meaningful route decision unless scan effects become much stronger.

### Scanner Energy

Pros:

- Creates room for future scanner upgrades and tool identity.
- Separates information economy from oxygen economy.

Cons:

- Adds a new resource before the core dive loop has been validated by unfamiliar players.
- Competes with oxygen, cargo, and upgrade requirements for player attention.
- Overbuilt for the current practical scan effects.

## Recommendation

Keep repeat tactical scans free for the current prototype.

The rule should remain:

- First-time scans cost `2` oxygen.
- Repeat scans of discovered targets cost `0` oxygen.
- Repeat scans may refresh the target's practical effect.

This fits the current design goal: scanning should help the player understand whether to continue downward or return safely. The first scan is the meaningful commitment; repeats are earned recall and tactical readability.

## Revisit Trigger

Open an implementation issue only if at least one of these becomes true:

- Players repeatedly spam scanning in a way that removes route risk.
- Repeat scans become combat, evasion, or predator-control tools rather than readability tools.
- A future scanner upgrade needs a dedicated scanner-energy economy.
- Blind playtests show that free repeat scans make oxygen pressure feel irrelevant.

Until then, do not change scan cost behavior.
