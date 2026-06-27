# First Noticeably Larger Dive Map Validation - 2026-06-27

Status: pass with watchlist.

This closes the player-visible milestone pivot that was created because many small issues were being completed without the normal play experience feeling different enough.

## Validation Method

This is a compact solo milestone validation, not a blind playtest. It uses:

- current implemented scene/runtime state after issues #519, #520, #516, and #517;
- quick Godot logic coverage;
- desktop Playwright visual smoke, including the staged expanded East Shelf route and staged East Shelf pocket payoff captures;
- current roadmap and gameplay contracts.

No new long review treadmill is created here. The next work should move to the next player-visible milestone rather than repeatedly revalidating East Shelf polish.

## Pivot Gate Answers

1. Did the game visibly feel larger than it did before this pivot?

Pass with watchlist. The East Shelf route now opens right from the original column with a stronger branch mouth, wider route silhouette, cave-like destination, payoff, and sealed deeper marker. The watchlist is that screenshots still prove this better than an ordinary unassisted play session, so later milestone closeouts should include a short non-debug traversal capture or manual route note.

2. Did the player encounter a clear branch or cave-like destination without debug staging?

Pass with watchlist. The branch and pocket are present in the normal scene, not debug-only, and the scene contract guards the branch mouth, cave back wall, shelf lip, spires, and pocket visuals. The watchlist is tuning the exact route approach if future manual play finds the branch still too easy to miss.

3. Did the destination contain something worth doing?

Pass. East Shelf Pocket now contains a visible SignalCore payoff. The prompt says to recover the signal core, interaction gives immediate feedback, the core visibly dims after recovery, and extraction result copy acknowledges the recovered core as a sealed-route clue.

4. Did the player understand how to return?

Pass with watchlist. The pocket, arch, lower connector, and later pockets use return-current cues plus broad base-direction copy such as up-left. This remains a no-minimap design and should continue relying on landmarks, return-current shape language, depth bands, and result memory instead of exact locators.

5. Did the next possible deeper goal feel visible but not mandatory?

Pass. DeepRoutePromise now sits just beyond the East Shelf destination as a non-interactive sealed lower route mouth with pressure wash, seal lip, glint, and `DEEP ROUTE SEALED` label. It has no interaction zone, no interior, no oxygen penalty, no objective checklist, and no new upgrade tier.

## Outcome

The milestone passes with watchlist. The project should stop treating East Shelf as a hidden prototype-only branch and can move forward to the next player-visible gameplay milestone.

Recommended next milestone shape:

- add a second ordinary-play reason to choose between the safer midwater route, East Shelf, and lower pockets;
- prefer one new playable decision or destination over another broad art/readability pass;
- include non-debug traversal evidence only at milestone closeout, not after every small change.

## Verification

- `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick` passed during the milestone closeout sequence.
- `npm.cmd run test:visual` passed 10/10 during the milestone closeout sequence.
- `git diff --check` passed for the files changed during the closeout sequence.

## Follow-Up Issues

None created from this validation. The milestone is not failed, and the watchlist items are process guidance for the next milestone rather than bugs requiring immediate East Shelf rework.
