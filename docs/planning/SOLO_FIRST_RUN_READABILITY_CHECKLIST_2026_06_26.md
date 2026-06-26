# Solo First-Run Readability Checklist - 2026-06-26

Status: solo review checklist for issue #297.

## Purpose

Use this when no outside helpers are available.

This is not blind validation. It is a repeatable solo developer checklist for catching first-run readability problems before asking anyone else to play.

## Setup

1. Launch the project normally from the repository root.
2. Use a clean first-run state when testing onboarding:
   - show debug telemetry if needed,
   - press F9 to reset prototype progression,
   - hide debug telemetry again before judging player-facing readability.
3. Keep the intended normal viewport and default camera zoom.
4. Do not use roadmap knowledge to excuse unclear screens. If a first-time player would need an explanation, record it as a readability issue.
5. Screenshots are optional but recommended when the issue is visual. Follow `docs/current/SCREENSHOT_WORKFLOW.md`.

## Pass 1: First Ready Screen

Check without pressing E/Enter yet:

- Can I tell I am at the surface/base before reading implementation notes?
- Does the ready panel say how to begin?
- Does the condition line explain why today's ocean feels different without exposing seed/debug terms?
- Does the goal line point to one useful next action?
- Are oxygen, depth, cargo, upgrades, discoveries, and debug-only text hidden or placed so they do not overlap the ready panel?
- Does the boat/moonpool art support the launch point without covering text?

Record:

- pass/fail/watchlist,
- confusing text or visual overlap,
- screenshot path if captured.

## Pass 2: First Dive Start

Press E or Enter and begin the first active dive:

- Does oxygen become the main pressure signal?
- Are movement, cargo, base direction, scan target, and prompt readable without the surface panel?
- Does the sub clearly separate from the background and boat/moonpool art?
- Does the HUD avoid overlapping world objects or itself at normal scale?
- Does the player understand that returning upward is safe?

Record:

- first moment of confusion,
- whether active HUD text is too long,
- whether the player/sub/background contrast is acceptable.

## Pass 3: First Pickup Or Scan

Find the first practical resource or scan target:

- Can the nearest target be noticed without a paragraph of world text?
- Does the selected scan target label match what is highlighted?
- If scanning, does F feel discoverable from the HUD prompt or target feedback?
- If collecting, does cargo count and slot feedback change clearly?
- Does the status text say what happened and the next useful action in one compact line?
- Does scanning avoid implying a minimap, exact locator, checklist, or field guide?

Record:

- which target was used,
- what changed on the HUD,
- whether the next action was clear.

## Pass 4: First Return Or Failure

Either return to base with cargo/scan data or intentionally run out of oxygen:

- Is the return/base direction readable while moving upward?
- Does extraction require leaving and returning in a way that makes sense?
- Does the result panel distinguish banked cargo from lost carried cargo?
- Does the result panel preserve one useful memory line without becoming a checklist?
- If oxygen fails, does it explain what was lost and what persisted?
- Does R clearly prepare the next expedition?

Record:

- extraction or failure,
- cargo/scans preserved,
- any confusing persistence wording.

## Pass 5: First Upgrade View

After extraction, switch to the upgrade view:

- Does Left/Right surface view switching remain visible?
- Does the upgrade panel show which upgrade is selected and its list position?
- Does Up/Down selection feel discoverable from panel copy?
- Does E or Enter purchase language appear only where purchase is relevant?
- Are cost, state, missing scan, missing upgrade, and missing resources clear?
- Does the view stay one selected upgrade at a time without becoming a tech tree or inventory grid?

Record:

- selected upgrade,
- whether Up/Down and E/Enter were clear,
- any copy overflow or panel contrast problem.

## Outcome Labels

Use these labels in follow-up notes:

- `Pass`: understandable at normal scale.
- `Pass with watchlist`: usable now, but vulnerable after future art/HUD changes.
- `Fail`: blocks first-run comprehension and should become an issue.
- `Out of scope`: noted, but belongs to a later milestone.

## Follow-Up Issue Shape

Create small issues from concrete failures:

```markdown
## Observation

<What was confusing during the solo first-run checklist.>

## Evidence

- Checklist pass:
- View/state:
- Screenshot path if any:
- Exact confusing text or visual:

## Proposed Scope

<Smallest copy, layout, visual, or behavior-neutral change that could fix it.>

## Acceptance Criteria

- [ ] First-run solo checklist pass no longer hits the confusion.
- [ ] Existing gameplay behavior remains unchanged unless explicitly authorized.
```

## Relationship To Blind Validation

Use `docs/planning/BLIND_VALIDATION_KIT.md` only when outside players are actually available. This solo checklist is valid internal evidence, but it should not be described as blind validation or substituted for player research when outside-player feedback is later possible.
