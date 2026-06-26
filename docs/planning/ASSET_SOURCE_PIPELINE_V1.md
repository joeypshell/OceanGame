# Asset Source Pipeline v1

Status: planning recommendation for the next few visual asset batches.

## Recommendation

Use a hybrid pipeline:

1. Keep gameplay-readable prototype assets in Godot scenes and scripts first.
2. Introduce source art files only when an asset's meaning is stable enough to replace or skin a prototype shape.
3. Prefer small, role-specific source assets over large packs.

This fits OceanGame's current state. The project is still discovering the visual language for route meaning, safe return, pressure locks, predator danger, scan targets, and mystery signals. Final-looking art should not outrun those decisions.

## Options Compared

### Godot Polygon / Scene-Authored Prototypes

Use for:

- route markers,
- pressure gates,
- danger lanes,
- safe-return cues,
- current hints,
- early landmark silhouettes.

Pros:

- fastest iteration inside the current scene,
- easy to review in code diffs,
- no import pipeline,
- keeps gameplay meaning explicit,
- avoids asset licensing concerns for placeholder shapes.

Cons:

- ugly if used too long,
- hard to build rich animation or texture,
- can become cluttered inside `Main.tscn`.

Decision: keep using this for readability-first mechanics and marker vocabulary.

### Hand-Authored Vector Sources

Use for:

- refined silhouettes,
- icons,
- small UI/marker assets,
- source files that need crisp scaling.

Pros:

- easy to edit and attribute,
- good fit for Godot 2D,
- can preserve shape language from prototypes,
- avoids bitmap resolution churn.

Cons:

- still needs export discipline,
- final style can feel flat unless paired with material/lighting work.

Decision: preferred first source-art format once a prototype asset graduates.

### Generated Bitmap Sources

Use for:

- mood concepts,
- texture studies,
- creature or landmark silhouettes after role is defined,
- future sprite paintovers.

Pros:

- useful for exploring alien-ocean mood quickly,
- can create visual appeal faster than raw polygons,
- good for concept directions before production art.

Cons:

- source prompt/provenance must be documented,
- style consistency can drift,
- license and attribution notes matter,
- raw generations should not be treated as final source without review.

Decision: allowed for concept and first-pass sprite direction, but not as unmanaged drop-in decoration.

### Third-Party Asset Packs

Use for:

- temporary UI fonts/icons only if license is clear,
- narrow placeholders when no internal source exists.

Pros:

- fast.

Cons:

- style mismatch,
- license risk,
- can obscure the game's specific visual language.

Decision: avoid for core ocean/gameplay assets unless the license is simple and the asset is clearly temporary.

## Folder Recommendation

Issue #160 should create the concrete conventions. Recommended shape:

```text
assets/
  source/
    concepts/
    sprites/
    vectors/
    ui/
    README.md
  exports/
    sprites/
    ui/
    README.md
  licenses/
    README.md
```

Intent:

- `assets/source/`: editable source files, prompts, references, and notes.
- `assets/exports/`: committed runtime-ready exported assets only when used by the Godot project.
- `assets/licenses/`: license, attribution, and provenance notes for non-original assets.

Do not commit Godot import caches:

- `.godot/`,
- `.import/`,
- `*.import`,
- generated platform exports,
- local editor state.

## Naming Convention

Use role-first names:

```text
<role>_<subject>_<variant>_<stage>.<ext>
```

Examples:

```text
danger_gulper_lane_v1.svg
creature_gulper_silhouette_concept_v1.png
lock_pressure_gate_v1.svg
resource_glow_plankton_sprite_v1.png
ui_scan_marker_v1.svg
```

Keep names tied to gameplay role, not only aesthetic description.

## Licensing And Attribution

Every committed non-original source asset needs an attribution note that records:

- asset name/path,
- creator or generation method,
- license or usage basis,
- source URL if applicable,
- date added,
- any restrictions,
- whether it is prototype-only or intended for production.

Generated images should record:

- prompt summary,
- generation tool if known,
- date,
- intended use,
- whether the image was edited afterward.

If provenance is unclear, do not commit the asset.

## First Asset Candidates

Good first candidates:

- `Glow Plankton` sprite source,
- `Kelp Fiber` frond source,
- `Shell Fragments` shard source,
- `Gulper Eel` silhouette concept,
- `Pressure Gate` vector source,
- compact scan marker icon source.

Avoid starting with:

- full biome background paintings,
- large creature animation sets,
- broad UI skin,
- particle-heavy effects,
- decorative assets with no gameplay readability role.

## Definition Of Ready

An asset is ready to move beyond prototype polygons when:

- the gameplay meaning is stable,
- the visual role is documented in `VISUAL_LANGUAGE_READABILITY_ASSETS.md`,
- screenshots show the current placeholder is readable but unattractive or too crude,
- the source file has clear provenance,
- the export can be regenerated without guessing.

## Definition Of Done

A first source-art implementation issue should:

- add source file and export file in the agreed folders,
- include or update attribution notes,
- replace one existing prototype visual without changing gameplay truth,
- verify Godot launch and `git diff --check`,
- update current gameplay docs if the visible behavior changes.

