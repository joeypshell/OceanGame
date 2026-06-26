# Next Source-Art After Moonpool Decision - 2026-06-26

Status: planning artifact for issue #291.

## Decision

Next source-art target: constrained shallow/midwater background study.

This should be a small readability-support pass, not a broad background overhaul.

## Candidate Comparison

| Candidate | Readability Value | Risk | Decision |
| --- | --- | --- | --- |
| Sub idle/thrust polish | Medium | Low | Plan constraints first; not the next implementation target because current recheck passes. |
| Pressure wreck/cache environment | High | Medium/high | Keep as backup; lower route is dense and risky to disturb before a calmer background pass. |
| Shallow/midwater background study | Medium/high | Medium | Select next. It can improve first-run mood and depth readability if contrast is constrained. |
| Landmark/resource polish | Medium | Low/medium | Defer until background contrast decisions are clearer. |

## Why Background Is Next

After the moonpool/waterline work, the first-run read is now strong enough to support a small environmental mood pass. The next visual weakness is not a single object; it is the flatness of the shallow/midwater space around the first dive.

A constrained background study can help:

- make the first descent feel more authored,
- distinguish shallow and midwater depth bands,
- make the game less placeholder-ugly without touching gameplay,
- set contrast rules before pressure/lower-route art becomes busier.

## Constraints

- Background must sit behind gameplay cues.
- Resources, scan targets, safe return, pressure gate, predator warning, player sub, and HUD must stay higher contrast.
- No parallax system unless separately scoped.
- No new biome, route, resource, predator, upgrade, or procedural generation.
- No production-art lock.

## Next Issues

- #292 should define shallow/midwater background art-pass constraints.
- #293 may wire a first source-art study only after constraints are clear.
- #294 should review whether the study helps or hurts gameplay readability.
