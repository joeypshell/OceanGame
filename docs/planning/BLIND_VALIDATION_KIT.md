# Blind Validation Kit

Use this kit when unfamiliar players are available. The project no longer requires full blind validation to advance; outside-player notes are optional bonus evidence.

When no helpers are available, use `docs/planning/SOLO_FIRST_RUN_READABILITY_CHECKLIST_2026_06_26.md` instead. That solo checklist is internal readability evidence only and should not be described as blind validation.

## Goal

Observe whether a player who has not read the roadmap or implementation notes understands the current expedition loop from the prototype itself.

Do not explain intended strategy, route design, upgrade goals, resource depth rules, predator behavior, or what the player "should" notice.

## Optional Testers

- At least two players.
- They should not have read the project roadmap, planning docs, issue threads, or implementation notes.
- Each player should play at least two expeditions.
- Record whether each player voluntarily starts a third expedition.

If helpers are not available, do not block roadmap progress on this section.

## Facilitator Setup

1. Launch the project from the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64.exe" --path .
```

2. Keep development telemetry hidden for the player-facing run.
3. Press F3 only when you need to record seed, cluster pattern, predator route, cargo, scans, contacts, oxygen result, or failure cause.
4. After each extraction or oxygen failure, press R to prepare the next seeded expedition.
5. If the player asks what to do, repeat only the control sheet below.

## Tester Control Sheet

Tell the player only this:

- Move with WASD or arrow keys.
- Press E or Enter to start a dive, interact, or extract when back at the safe base.
- Press F to scan the highlighted target.
- Press R after a result to start the next expedition.
- Press F3 is for the facilitator only.

Do not mention:

- which resources are shallow, midwater, or deep,
- the deep reward lure,
- predator warning purpose,
- how to unlock `Pressure Seal I`,
- the pressure-locked wreck payoff,
- the difference between carried and banked resources unless the player asks after the test.

## Per-Player Notes

The facilitator owns these notes. Testers should not be asked to fill out forms during the run. If structured note taking gets in the way, use the lightweight fallback below and fill it out after watching the session.

## Lightweight Facilitator Fallback

Use this when players will play but will not fill out forms, or when a short informal session produces useful evidence.

- Date:
- Player alias or group:
- What did they do first?
- Did they scan the first nearby item? yes/no
- After the first scan, what did they try to do next?
- What did they seem to think the objective was?
- What made them turn around, stop, ask for help, or lose interest?
- What concrete follow-up issue should be created?

This fallback is valid partial evidence. It can justify follow-up issues, but it is not required for roadmap progress.

### Player

- Date:
- Player alias:
- Prior genre familiarity:
- Did they read any project docs? yes/no
- Facilitator:

### First Expedition

- Expedition number:
- Seed:
- Cluster pattern:
- Where did the player go first?
- What did the player say or seem to believe the objective was?
- Did the player leave the base before trying to extract?
- Did the player collect a resource? Which one?
- Did the player scan without prompting?
- Did the player notice the scan target label or highlight?
- Did the player notice the deep reward lure?
- Did the player notice predator warning feedback before contact?
- Predator contacts:
- Turnaround point:
- Why did the player turn around?
- Result:
- Oxygen at result:
- Did they understand carried versus banked resources?
- Confusion, unintended strategy, or boredom:

### Second Expedition

- Expedition number:
- Seed:
- Cluster pattern:
- Did the route or cargo plan change from expedition one?
- What changed?
- Did the player use scanning differently?
- Did the player pursue or avoid the deeper route?
- Did predator warning feel fair?
- Predator contacts:
- Turnaround point:
- Why did the player turn around?
- Result:
- Oxygen at result:
- Did the player understand what was persistent between expeditions?
- Confusion, unintended strategy, or boredom:

### Third Expedition Check

- Did the player voluntarily start a third expedition? yes/no
- If yes, why?
- If no, why did they stop?

## Observer Prompts

Use these only after the player has finished at least two expeditions:

- What did you think your main goal was?
- What did you think would happen if you returned to the base?
- What did you think was kept after a failed dive?
- What did scanning seem useful for?
- Did anything make you want to go deeper?
- Did anything make you decide to turn back?
- Did the predator feel avoidable, unfair, or unclear?
- Was anything boring, confusing, or too small to notice?

## Follow-Up Issue Capture

Create follow-up issues only for concrete observations. Use this shape:

```markdown
## Observation

<What at least one player did, missed, misunderstood, or found boring.>

## Evidence

- Player:
- Expedition/seed:
- Relevant quote or behavior:

## Proposed Scope

<Smallest change that could address it.>

## Acceptance Criteria

- [ ] <Observable result>
- [ ] Existing behavior that must not regress: <current loop behavior>
```

Prefer several small issues over one broad "improve onboarding" issue.

## Optional Outside-Player Completion Checklist

- [ ] Two unfamiliar players tested.
- [ ] Controls only explained before play.
- [ ] At least two expeditions recorded per player.
- [ ] Route choice, objective understanding, scanning, banking, predator warning, deep lure, and third-expedition motivation recorded.
- [ ] If testers will not fill forms, facilitator summaries are recorded instead.
- [ ] Raw notes linked from a planning note or the relevant issue.
- [ ] Concrete follow-up issues created from observations.
