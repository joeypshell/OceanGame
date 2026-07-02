# Map Pipeline Tool and Agent Guide

## 12. When to use Godot TileMapLayer

Godot’s `TileMapLayer` is appropriate when:

- the map is grid/tile-based,
- terrain should be painted quickly,
- the level is large,
- repeated tile art is available,
- collision can live in tile data,
- foreground/background tile layers need separation.

Use TileMapLayer later if the grid source stabilizes and terrain art becomes tile-based.

Short-term OceanGame can still use generated `Polygon2D` and `CollisionPolygon2D` if the source map is deterministic.

---

## 13. When to use Tiled

Use Tiled when you want an external visual editor with:

- tile layers,
- object layers,
- polygon/point/rectangle objects,
- custom properties,
- parallax layer factors,
- JSON export.

Recommended Tiled layer names for OceanGame:

```text
Solid
PlayableWater
OxygenSurface
ShipOffload
ResourceSpawns
ScanTargets
Hazards
Gates
ReturnCurrents
ReviewPoints
ParallaxFar
ParallaxMid
ForegroundDecor
```

Codex should parse Tiled JSON and not manually infer objects from screenshots.

---

## 14. When to use LDtk

Use LDtk when you want:

- structured game-oriented level data,
- levels with layer instances,
- entity definitions,
- fields/custom data,
- strong editor-side structure.

Recommended LDtk entities:

```text
PlayerStart
ShipOffload
OxygenSurface
ResourceSpawn
ScanTarget
HazardZone
Gate
ReturnCurrent
ReviewPoint
RegionMarker
```

Use LDtk after the simpler source-grid pipeline proves the map schema.

---

## 15. Agent-sprite-forge usage rules

The `generate2dmap` skill is useful, but do not let it drive topology from images.

Use it for these decisions:

```text
map_mode = side_scroll_mode
visual_model = parallax_layers or layered_tilemap
runtime_object_model = platform_objects + interactive_scene_objects + foreground_occluders + scene_hooks
collision_model = precise_shapes or tile_collision
engine_target = Godot_TileMap or project-native
```

For OceanGame, the useful part is the layer/runtime/collision contract.

Do not ask it to “generate a pretty map and make that playable” unless the map also exports structured terrain, hooks, collision, and preview metadata.

Use `generate2dsprite` separately for:

- diver sprites,
- sub sprites,
- fish,
- predators,
- resources,
- UI icons,
- wall tile sprites,
- platform strips.

Do not use `generate2dsprite` for map topology.

---

## 16. Prompt rules for Codex

### Bad prompt

```text
Make the terrain match this image.
Fix the map.
Make it look like the generated screenshot.
```

### Better prompt

```text
Do not edit wall polygons manually.
Edit the machine-readable source map or converter only.
Regenerate runtime geometry.
Generate source/runtime/diff previews.
Validation must pass before Godot screenshot review.
Godot must consume generated geometry.
```

### Map task standard opening

```text
This is a map-source reproducibility task, not a visual polish task.
Do not add new gameplay, routes, resources, creatures, or art polish.
The only accepted topology source is the machine-readable map source.
Generated runtime geometry must not be hand-edited.
```

---

## 17. Codex master prompt for new map-pipeline work

```text
Use the OceanGame map-source pipeline.

Do not infer collision or routes from screenshots.

Source of truth:
data/maps/area_01_source_grid_v1.json

Generated output:
data/maps/area_01_runtime_geometry.generated.json

Run:
node tools/build-area01-map.mjs --validate --write --previews

Godot must consume generated geometry only.

Acceptance:
- open surface water exists,
- continuous seafloor mass exists,
- cave holes and corridors are carved through it,
- resources/scans/hooks are in playable water,
- generated runtime preview matches source preview,
- Godot renders the same topology,
- no manual polygon tuning,
- no new gameplay/content/polish.
```

---

## 18. Visual-art workflow after topology is stable

Only after source/runtime parity works:

1. Build a terrain tile/strip kit.
2. Add wall top/middle/bottom/corner/slope pieces.
3. Add cave-mouth frames.
4. Add parallax background layers.
5. Add foreground occluders.
6. Add resource sprites.
7. Add scan-target sprites.
8. Add vegetation/coral decoration.

Rules:

- collision remains from map data,
- art does not own collision,
- collision-critical terrain pieces are not generated in square prop packs,
- platforms/walls use strips, tiles, or one-by-one assets,
- final art is accepted only if preview and Godot map still match.

---
