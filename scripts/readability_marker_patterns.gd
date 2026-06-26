class_name ReadabilityMarkerPatterns
extends RefCounted

const SCAN_MARKER_IDLE_COLOR := Color(0.95, 1.0, 0.7, 0.24)
const SCAN_MARKER_SELECTED_COLOR := Color(1.0, 1.0, 0.55, 0.54)
const SCAN_BRACKET_IDLE_COLOR := Color(0.9, 1.0, 1.0, 0.0)
const SCAN_BRACKET_SELECTED_COLOR := Color(0.9, 1.0, 1.0, 0.34)

static func scan_marker_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(0, -36),
		Vector2(28, -18),
		Vector2(36, 0),
		Vector2(28, 18),
		Vector2(0, 36),
		Vector2(-28, 18),
		Vector2(-36, 0),
		Vector2(-28, -18),
	])

static func scan_focus_bracket_a_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(-48, -42),
		Vector2(-24, -42),
		Vector2(-24, -34),
		Vector2(-40, -34),
		Vector2(-40, -18),
		Vector2(-48, -18),
	])

static func scan_focus_bracket_b_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(48, 42),
		Vector2(24, 42),
		Vector2(24, 34),
		Vector2(40, 34),
		Vector2(40, 18),
		Vector2(48, 18),
	])

static func scan_marker_color(selected: bool) -> Color:
	return SCAN_MARKER_SELECTED_COLOR if selected else SCAN_MARKER_IDLE_COLOR

static func scan_bracket_color(selected: bool) -> Color:
	return SCAN_BRACKET_SELECTED_COLOR if selected else SCAN_BRACKET_IDLE_COLOR

static func ensure_focus_bracket(owner: Node, node_name: String, polygon: PackedVector2Array) -> Polygon2D:
	var bracket := owner.get_node_or_null(node_name) as Polygon2D
	if bracket == null:
		bracket = Polygon2D.new()
		bracket.name = node_name
		owner.add_child(bracket)

	bracket.polygon = polygon
	return bracket
