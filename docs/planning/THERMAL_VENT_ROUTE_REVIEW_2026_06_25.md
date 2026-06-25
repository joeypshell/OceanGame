# Thermal Vent Route Review - 2026-06-25

Status: focused five-seed route review for #95 after the Thermal Vent pocket and vent-adjacent placement candidates were added.

## Review Method

This pass reviewed the first five deterministic expedition seeds against the authored scene layout and current route language. It focuses on whether the new `Thermal Vent` pocket reads as an optional clue route without overwhelming Shell Reef banking, pressure-wreck feedback, Glow Plankton temptation, predator warning, or safe-return language.

This note does not implement tuning. Any changes should happen in the follow-up #96 issue.

## Five-Seed Review

| Expedition | Seed | Pattern | Vent Readability | Shell Reef Interaction | Pressure-Gate Interaction | Glow Temptation | Predator Pressure | Return Clarity | Notes |
| --- | ---: | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 8919 | Deep reward route | Warm wash and bubble strings make the vent feel like a place instead of a lone scan target. | Reef still reads as the safer midwater bank before the player drops toward the vent. | Pressure gate remains visually separate because locked cyan/blue shimmer is stronger than vent orange. | Strong: deep-reward pattern plus vent-adjacent glow candidates can make the clue feel worth checking. | Medium: pushing beyond the clue can still put the player near contested deep routes. | Good if the player turns back at the vent; risk rises if following glow. | Useful route tension; no resource count increase observed by design. |
| 2 | 16838 | Cautious shallows | Vent still reads as optional knowledge rather than a mandatory route. | Reef banking remains the clearer resource route. | The vent's Pressure Seal clue is useful but should not point too hard at the locked route. | Low to medium: without deep-reward pattern, the vent is more about knowledge than cargo. | Low unless the player overcommits after scanning. | Strong: safe-return language has room around the pocket. | Good cautious contrast against seed 1. |
| 3 | 24757 | Deep reward route | Pocket identity is readable, especially with warm current language. | Shell Reef and vent offer distinct choices: bank midwater or investigate lower clue. | No immediate conflict, but the scan-revealed route arrow should stay softer than lock language. | Strong: the vent can tempt a deeper glow push without promising safety. | Medium to high if the player chains vent clue into deep glow. | Adequate, but depends on not stacking too many bright hints near the lower midwater. | Best candidate for watching visual clutter in #96. |
| 4 | 32676 | Cautious shallows | Vent works as a future-route landmark even when cargo play stays shallower. | Reef remains more practical for Shell Fragments and banking. | Pressure Seal knowledge has a clear surface-return implication. | Low: no need to chase glow on this pattern. | Low: route pressure comes mainly from optional overextension. | Good: the player can scan and return without feeling forced down. | Supports the intended contrast between cautious and deep-reward runs. |
| 5 | 40595 | Deep reward route | Warm pocket plus optional glow language make the route legible. | Reef still anchors the bank-or-push decision above the vent. | Pressure gate remains distinct, but the vent clue and pressure clue are close enough that text must stay concise. | Strong: likely to invite a meaningful oxygen-spend decision. | Medium: predator pressure should stay a consequence of pushing past the clue, not scanning the vent itself. | Good if the player recognizes the vent as a turnaround point. | Follow-up should tune clarity, not add mechanics. |

## Findings

- The pocket creates a useful second authored place identity after Shell Reef. It reads as warm geology/route knowledge rather than another shell landmark.
- Shell Reef still owns the safer midwater banking decision. The vent sits lower and supports a different question: spend oxygen to inspect/follow a clue, or return with the discovery.
- The pressure gate remains readable because its locked cyan shimmer and hard gate shapes are visually louder than the vent pocket.
- The new scan/result language helps prevent the vent from becoming a guaranteed path: it names glow as optional and the Pressure Seal clue as bankable surface knowledge.
- Deep-reward seeds should be watched for visual stacking between `ThermalVentPocket`, `VentRouteHint`, `DeepRewardLure`, predator warning, and pressure-wreck promise.

## Recommendation For #96

Make one narrow readability tuning pass rather than changing placement, resource counts, costs, or mechanics.

Recommended #96 scope:

- keep the authored vent pocket and vent-adjacent candidates,
- tune only the scan-revealed `VentRouteHint` language or opacity if needed,
- make the hint read as an optional warm-current clue rather than a hard objective arrow,
- preserve the distinction between warm vent clue, yellow-green reward lure, cyan pressure lock, red/orange predator danger, and safe-return language.

Do not add:

- new resources,
- oxygen refills,
- additional scan targets,
- pressure-route changes,
- predator behavior changes,
- procedural pocket generation.

## Success Read

The Thermal Vent pocket is directionally working. It should move to #96 for a small readability tuning pass, not a redesign.
