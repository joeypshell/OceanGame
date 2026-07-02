# OceanGame Agentic 2D Map-Building Practices

Status: working playbook for Codex/Claude map tasks
Audience: Codex, Claude, and human review
Primary goal: make OceanGame map work deterministic, reproducible, and player-readable.

---

## 0. Core conclusion

OceanGame should stop asking an agent to “make the map look like the screenshot.”

For playable 2D maps, the agent must work from a machine-readable source of truth:

```text
machine-readable source map
→ deterministic converter/importer
→ generated runtime geometry
→ generated source/runtime/diff previews
→ Godot builder/importer
→ Playwright/Godot screenshot confirmation
```

Pretty concept art may guide style, but it must not define collision, walls, playable water, resources, scan targets, gates, or routes.

The map pipeline should be treated as gameplay infrastructure, not art polish.

---

## 1. Why the current process is failing

The current failure mode is predictable:

```text
visual source map / concept
→ Codex interprets intended walls
→ Codex edits JSON polygons or Godot scene nodes
→ Godot renders something different
→ screenshot review
→ more manual fixes
→ still not reproducible
```

This is unstable because Codex is doing visual interpretation and coordinate translation by intuition.

For OceanGame specifically, the mismatch is:

```text
Current rendered map:
- floating solid chunks
- mostly open water
- hand-tuned polygons and rims

Intended map:
- open water surface
- continuous seafloor / reef mass
- carved cave holes and corridors
- explicit hooks for oxygen, ship offload, pickups, scans, hazards, gates, return currents
```

The fix is not more hand-tuning. The fix is to make the map source deterministic.

---

## 2. Non-negotiable principles

### Principle 1: Topology is data, not art

The map source must explicitly say what is:

- solid terrain,
- playable water,
- open surface water,
- ship/offload zone,
- oxygen refill zone,
- resource spawn,
- scan target,
- hazard,
- gate / locked promise,
- return current,
- camera/review point.

Do not infer these from a pretty image.

### Principle 2: Visuals decorate topology

Terrain art, parallax, kelp, coral, lighting, rim sprites, wall decals, and foreground dressing must decorate the playable map. They must not own collision or route truth.

### Principle 3: Runtime geometry is generated

Generated runtime geometry may use polygons, rectangles, TileMap cells, or collision polygons. But it should be emitted by a converter/importer from a source map, not manually authored as the source.

### Principle 4: The same geometry source must drive visible terrain and collision

For every current Area 01 wall or solid:

```text
visible terrain source == collision source == rim/lip source
```

If these drift, players will hit invisible blockers or see walls they can swim through.

### Principle 5: Preview before Godot

The agent must generate a source preview, runtime preview, and preferably a diff/overlay before relying on Godot screenshots.

Godot/Playwright screenshots are the final confirmation, not the first debugging tool.

### Principle 6: Coarse and correct beats organic and wrong

A blocky grid map that matches the source topology is better than a beautiful irregular polygon map that does not.

Make the map correct first. Make it pretty later.

---

## 3. Recommended source-map ladder

### Stage 1: strict grid JSON

Best immediate fit for OceanGame.

Use a file like:

```text
data/maps/area_01_source_grid_v1.json
```

Benefits:

- easiest for Codex to edit safely,
- deterministic,
- diffable,
- no image interpretation,
- easy validation,
- easy preview generation.

Weakness:

- initially blocky unless later smoothed or decorated.

Use this now.

### Stage 2: strict-palette PNG

Good if Joey wants to “upload a map.”

Rules:

- exact colors only,
- no antialiasing,
- no gradients,
- fixed scale,
- every color has one meaning.

Example palette:

```text
#ffffff = playable water
#808080 = solid terrain
#00ffff = open surface / oxygen
#ff9900 = ship offload
#00ff00 = resource spawn
#ff00ff = scan target
#ff0000 = hazard
#ffff00 = gate / locked promise
#0000ff = return current
```

Weakness:

- easy to accidentally introduce antialiasing or ambiguous pixels.

Use after grid JSON proves the pipeline.

### Stage 3: Tiled or LDtk

Best long-term professional authoring path.

Tiled and LDtk are better when the map needs:

- layered tile data,
- object layers,
- custom properties,
- parallax layers,
- entity/object placement,
- human visual editing.

Use after OceanGame’s source schema stabilizes.

---

## 4. Preferred immediate architecture

Use this pipeline now:

```text
data/maps/area_01_source_grid_v1.json
  ↓
tools/build-area01-map.mjs
  ↓
data/maps/area_01_runtime_geometry.generated.json
  ↓
artifacts/maps/area_01_source_grid_preview.svg
artifacts/maps/area_01_runtime_geometry_preview.svg
artifacts/maps/area_01_diff_overlay.svg
  ↓
scripts/area01_blockout_builder.gd
  ↓
Godot runtime terrain + collision + hooks
```

Godot should consume the generated geometry, not hand-edited geometry.

---

## 5. Detail pages

- [`map-pipeline/SCHEMAS_AND_REQUIREMENTS.md`](map-pipeline/SCHEMAS_AND_REQUIREMENTS.md) owns the grid schema, converter requirements, runtime geometry schema, Godot builder requirements, and preview requirements.
- [`map-pipeline/TOOL_AND_AGENT_GUIDE.md`](map-pipeline/TOOL_AND_AGENT_GUIDE.md) owns the TileMap/Tiled/LDtk guidance, agent-sprite-forge rules, Codex prompt rules, and post-topology art workflow.

## 10. Map validation checklist

The validator must fail if any of these occur:

- unknown grid character,
- inconsistent row width,
- no open surface band,
- open surface not broad enough,
- ship offload hook missing,
- oxygen surface/refill hook missing,
- player spawn missing,
- player spawn not in playable water,
- required region missing,
- resource hook inside solid terrain,
- scan hook inside solid terrain,
- hazard/gate improperly placed,
- review point inside solid terrain,
- playable water connectivity does not match expected route graph,
- camera review point is mostly blank water when it should show a cave/pocket,
- generated runtime preview does not resemble source topology,
- generated file was hand-edited.

Connectivity checks should be grid-based first. Do not use screenshots to discover basic topology errors.

---

## 11. Acceptance gate for Codex map tasks

A Codex map task is not complete unless:

- source map was updated or intentionally unchanged,
- converter was run,
- generated runtime geometry was updated,
- validation passed,
- source/runtime/diff previews were generated,
- Godot consumed generated geometry,
- Godot launched,
- logic tests passed,
- Playwright/Godot screenshot only confirms rendering, not topology.

Do not accept “looks okay in one screenshot” as proof.

---

## 19. Review cadence

For each map change:

1. Review source grid.
2. Run converter.
3. Review source/runtime/diff preview.
4. Run validation.
5. Run Godot headless.
6. Run logic tests.
7. Capture one targeted screenshot.
8. Compare against gameplay intent.

Do not run broad screenshot passes before the source/runtime preview is correct.

---

## 20. Recommended next steps for OceanGame

1. Freeze manual Area 01 polygon fixing.
2. Add grid-source file.
3. Add converter.
4. Add generated runtime geometry.
5. Wire Godot builder to generated geometry.
6. Add validator.
7. Add preview artifacts.
8. Then resume survival day/night gameplay work.

The map pipeline is the blocker. Fixing it will make future map uploads realistic.

---

## 21. What to avoid

Do not:

- hand-author generated geometry,
- keep multiple competing map authority files,
- let Main.tscn own map topology,
- use pretty generated maps as collision authority,
- infer collision from antialiased PNGs,
- fix topology with labels,
- add route content while topology is unstable,
- treat one Playwright screenshot as map correctness,
- ask Codex to visually guess wall shapes.

---

## 22. Definition of done for the map pipeline

The pipeline is working when this is true:

```text
Edit source map
→ run one command
→ generated geometry updates
→ previews update
→ validation passes
→ Godot map matches the source topology
```

If that is not true, the pipeline is not done.
