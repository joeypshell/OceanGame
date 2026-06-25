# Oxygen Margin Tuning - 2026-06-25

This pass uses the new run telemetry checklist fields to evaluate five seeded routes after adding the deep-reward lure and predator warning feedback. It focuses on small tuning only: oxygen pressure should stay readable, with no decompression, ascent drain, depth modifier, or hidden cost.

## Tuning Change

- Passive oxygen drain changed from `1.0` to `0.95` oxygen per second.
- Resource collection remains `1` oxygen.
- Scan cost remains `2` oxygen.
- Predator contact remains `5` oxygen.

Reason: deep-reward routes need a little more recovery space for one scan or one predator contact, but the action costs are already understandable and should stay stable.

## Five-Seed Pass

| Run | Seed | Pattern | Route | Cargo Goal | Scan Plan | Contact Assumption | Oxygen Read | Tuning Judgment |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 8919 | Deep reward route | Follow lure toward predator-side `Glow Plankton`. | Kelp, Shell, Glow | Optional Lantern Fry | Avoid contact | Close but fair with `0.95` passive drain. | Keep. |
| 2 | 16838 | Cautious shallows | Bank shallow/midwater resources. | Kelp, Shell | Optional Thermal Vent | No contact | Comfortable return, as intended. | Keep. |
| 3 | 24757 | Deep reward route | Push deeper after midwater resource. | Shell, Glow | One scan | Avoid or recover from one contact | One scan plus cautious return remains viable. | Keep. |
| 4 | 32676 | Cautious shallows | Early banking route. | Kelp, Shell | No scan | No contact | Not pressured unless player overextends. | Keep. |
| 5 | 40595 | Deep reward route | Attempt deep material near predator band. | Kelp, Shell, Glow | One scan | One contact possible | One contact should create critical return tension, not automatic failure. | Keep with follow-up playtest. |

## Outcome

The tuning keeps the oxygen model readable while softening the sharpest deep-reward edge. The intended results are:

- cautious routes remain comfortable enough to teach banking,
- deep-reward routes still create return tension,
- one scan is less punishing on deep-reward routes,
- one predator contact remains serious without necessarily ending the run,
- low/critical oxygen feedback still provides the emotional pressure layer.

## Remaining Risks

- A real player may move less efficiently than this route review assumes.
- Predator contact timing still needs observation with human piloting.
- If deep-reward runs become too easy after hands-on testing, restore passive drain toward `1.0` before changing action costs.
