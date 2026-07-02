class_name CargoSlotPresenter
extends RefCounted

static func cargo_slot_states(resource_ids: Array, capacity: int, visible_slots := 4) -> Array[String]:
	var states: Array[String] = []
	for index in range(visible_slots):
		if index >= capacity:
			states.append("hidden")
		elif index < resource_ids.size():
			states.append(String(resource_ids[index]))
		else:
			states.append("empty")

	return states

static func cargo_slot_color(state: String) -> Color:
	match state:
		"kelp_fiber":
			return Color(0.14, 0.42, 0.24, 0.72)
		"shell_fragments":
			return Color(0.46, 0.34, 0.16, 0.72)
		"glow_plankton":
			return Color(0.38, 0.52, 0.12, 0.76)
		"scrap_metal":
			return Color(0.28, 0.42, 0.46, 0.72)
		"driftwood":
			return Color(0.45, 0.31, 0.16, 0.72)
		"quartz_glass":
			return Color(0.15, 0.55, 0.66, 0.72)
		"food_supply":
			return Color(0.46, 0.25, 0.1, 0.72)
		"water_supply":
			return Color(0.1, 0.32, 0.46, 0.72)
		"power_supply":
			return Color(0.42, 0.38, 0.1, 0.72)
		"hidden":
			return Color(0.0, 0.0, 0.0, 0.0)
		"locked":
			return Color(0.012, 0.025, 0.032, 0.22)
		_:
			return Color(0.055, 0.16, 0.19, 0.5)

static func cargo_slot_icon_polygon(state: String) -> PackedVector2Array:
	match state:
		"kelp_fiber":
			return PackedVector2Array([Vector2(-3, 9), Vector2(-8, 4), Vector2(-4, -8), Vector2(0, -10), Vector2(3, 8), Vector2(8, 2), Vector2(6, 8)])
		"shell_fragments":
			return PackedVector2Array([Vector2(-9, 7), Vector2(-5, -5), Vector2(0, -9), Vector2(5, -5), Vector2(9, 7), Vector2(3, 10), Vector2(-3, 10)])
		"glow_plankton":
			return PackedVector2Array([Vector2(0, -9), Vector2(8, 0), Vector2(0, 9), Vector2(-8, 0)])
		"scrap_metal":
			return PackedVector2Array([Vector2(-9, -5), Vector2(3, -9), Vector2(10, -2), Vector2(6, 7), Vector2(-7, 9), Vector2(-11, 1)])
		"driftwood":
			return PackedVector2Array([Vector2(-11, 5), Vector2(-4, -8), Vector2(2, -5), Vector2(9, -9), Vector2(5, 7), Vector2(-5, 10)])
		"quartz_glass":
			return PackedVector2Array([Vector2(0, -11), Vector2(8, -3), Vector2(6, 7), Vector2(0, 11), Vector2(-7, 6), Vector2(-8, -4)])
		"food_supply":
			return PackedVector2Array([Vector2(-8, -7), Vector2(8, -7), Vector2(10, 3), Vector2(2, 10), Vector2(-9, 6)])
		"water_supply":
			return PackedVector2Array([Vector2(0, -10), Vector2(8, -1), Vector2(5, 9), Vector2(-5, 9), Vector2(-8, -1)])
		"power_supply":
			return PackedVector2Array([Vector2(-3, -10), Vector2(7, -2), Vector2(1, -1), Vector2(5, 10), Vector2(-7, 0), Vector2(-1, 0)])
		_:
			return PackedVector2Array()

static func cargo_slot_icon_color(state: String) -> Color:
	match state:
		"kelp_fiber":
			return Color(0.78, 1.0, 0.74, 0.95)
		"shell_fragments":
			return Color(1.0, 0.96, 0.74, 0.95)
		"glow_plankton":
			return Color(0.98, 1.0, 0.54, 0.98)
		"scrap_metal":
			return Color(0.72, 0.92, 0.98, 0.98)
		"driftwood":
			return Color(1.0, 0.72, 0.4, 0.98)
		"quartz_glass":
			return Color(0.6, 1.0, 1.0, 0.98)
		"food_supply":
			return Color(1.0, 0.86, 0.58, 0.98)
		"water_supply":
			return Color(0.74, 0.96, 1.0, 0.98)
		"power_supply":
			return Color(1.0, 1.0, 0.52, 0.98)
		_:
			return Color(1.0, 1.0, 1.0, 0.0)
