extends RefCounted

class_name ToolBeltPresenter

static func tool_slot_color(state: String) -> Color:
	match state:
		"active":
			return Color(0.06, 0.36, 0.42, 0.68)
		"ready":
			return Color(0.018, 0.075, 0.095, 0.5)
		"cooldown":
			return Color(0.09, 0.08, 0.035, 0.54)
		"spent":
			return Color(0.05, 0.055, 0.065, 0.44)
		"locked":
			return Color(0.012, 0.02, 0.028, 0.34)
		_:
			return Color(0.014, 0.024, 0.032, 0.34)


static func tool_key_color(state: String) -> Color:
	match state:
		"active":
			return Color(0.72, 1.0, 1.0, 1.0)
		"ready":
			return Color(0.88, 0.96, 1.0, 0.96)
		"cooldown":
			return Color(1.0, 0.82, 0.38, 0.92)
		"locked", "spent":
			return Color(0.62, 0.7, 0.74, 0.82)
		_:
			return Color(0.5, 0.55, 0.6, 0.75)


static func tool_icon_color(tool_id: String, state: String) -> Color:
	if state == "locked" or state == "spent":
		return Color(0.45, 0.56, 0.62, 0.72)
	match tool_id:
		"scanner":
			return Color(0.1, 0.92, 1.0, 0.98)
		"burst":
			return Color(0.55, 0.92, 1.0, 0.98)
		"cutter":
			return Color(1.0, 0.82, 0.48, 0.98)
		"decoy":
			return Color(0.45, 0.88, 1.0, 0.98)
		"reserve":
			return Color(1.0, 0.72, 0.58, 0.98)
		_:
			return Color(0.8, 0.9, 1.0, 0.88)


static func tool_icon_polygon(tool_id: String) -> PackedVector2Array:
	match tool_id:
		"scanner":
			return PackedVector2Array([Vector2(-12, -3), Vector2(-4, -12), Vector2(10, -9), Vector2(14, 0), Vector2(8, 10), Vector2(-7, 9), Vector2(-14, 2)])
		"burst":
			return PackedVector2Array([Vector2(-13, 7), Vector2(-2, -12), Vector2(4, -3), Vector2(13, -6), Vector2(3, 12), Vector2(-3, 3)])
		"cutter":
			return PackedVector2Array([Vector2(-12, 9), Vector2(-4, -8), Vector2(3, -11), Vector2(12, -3), Vector2(4, 1), Vector2(0, 11)])
		"decoy":
			return PackedVector2Array([Vector2(0, -13), Vector2(10, -5), Vector2(10, 7), Vector2(0, 13), Vector2(-10, 7), Vector2(-10, -5)])
		"reserve":
			return PackedVector2Array([Vector2(-11, -8), Vector2(11, -8), Vector2(11, 8), Vector2(-11, 8)])
		_:
			return PackedVector2Array()
