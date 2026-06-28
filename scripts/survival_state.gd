class_name SurvivalState
extends RefCounted

const SUPPLY_FOOD := "food_supply"
const SUPPLY_WATER := "water_supply"
const SUPPLY_POWER := "power_supply"
const SUPPLY_IDS := [SUPPLY_FOOD, SUPPLY_WATER, SUPPLY_POWER]
const MAX_DAYS := 5
const STARTING_NEED := 3
const OXYGEN_PENALTY_PER_ZERO_NEED := 4.0

var current_day := 1
var max_days := MAX_DAYS
var food := STARTING_NEED
var water := STARTING_NEED
var power := STARTING_NEED
var chapter_failed := false
var chapter_complete := false

func reset_chapter() -> void:
	current_day = 1
	max_days = MAX_DAYS
	food = STARTING_NEED
	water = STARTING_NEED
	power = STARTING_NEED
	chapter_failed = false
	chapter_complete = false

func is_supply_id(item_id: String) -> bool:
	return SUPPLY_IDS.has(item_id)

func display_name_for_supply(item_id: String) -> String:
	match item_id:
		SUPPLY_FOOD:
			return "Food Supply"
		SUPPLY_WATER:
			return "Water Supply"
		SUPPLY_POWER:
			return "Power Cell"
		_:
			return item_id

func short_name_for_supply(item_id: String) -> String:
	match item_id:
		SUPPLY_FOOD:
			return "Food"
		SUPPLY_WATER:
			return "Water"
		SUPPLY_POWER:
			return "Power"
		_:
			return item_id

func bank_supply(item_id: String) -> bool:
	match item_id:
		SUPPLY_FOOD:
			food += 1
			return true
		SUPPLY_WATER:
			water += 1
			return true
		SUPPLY_POWER:
			power += 1
			return true
	return false

func most_needed_supply_id() -> String:
	var needs := {
		SUPPLY_FOOD: food,
		SUPPLY_WATER: water,
		SUPPLY_POWER: power,
	}
	var selected := SUPPLY_FOOD
	var selected_value := int(needs[selected])
	for supply_id in SUPPLY_IDS:
		var value := int(needs[supply_id])
		if value < selected_value:
			selected = supply_id
			selected_value = value
	return selected

func resolve_night() -> Array[String]:
	var lines: Array[String] = []
	if chapter_failed:
		lines.append("Night report: chapter already collapsed. Restart Emergency Week.")
		return lines
	if chapter_complete:
		lines.append("Night report: base stabilized. Survival clock is paused for this prototype.")
		return lines

	food -= 1
	water -= 1
	power -= 1
	lines.append("Night consumed Food, Water, and Power.")

	if _has_collapse():
		chapter_failed = true
		lines.append("Collapse: a survival need fell below 0. Restart Emergency Week; major knowledge and upgrades stay.")
		return lines

	if current_day >= max_days:
		chapter_complete = true
		lines.append("Emergency Week stabilized after Day %d." % current_day)
		return lines

	current_day += 1
	if oxygen_penalty() > 0.0:
		lines.append("Warning: a need hit 0. Tomorrow starts with reduced oxygen.")
	lines.append("Day %d begins tomorrow." % current_day)
	return lines

func oxygen_penalty() -> float:
	var zero_needs := 0
	if food == 0:
		zero_needs += 1
	if water == 0:
		zero_needs += 1
	if power == 0:
		zero_needs += 1
	return float(zero_needs) * OXYGEN_PENALTY_PER_ZERO_NEED

func status_line() -> String:
	var suffix := ""
	if chapter_failed:
		suffix = " | COLLAPSE"
	elif chapter_complete:
		suffix = " | STABILIZED"
	elif oxygen_penalty() > 0.0:
		suffix = " | O2 penalty"
	return "Survival F%d W%d P%d%s" % [food, water, power, suffix]

func to_save_data() -> Dictionary:
	return {
		"current_day": current_day,
		"max_days": max_days,
		"food": food,
		"water": water,
		"power": power,
		"chapter_failed": chapter_failed,
		"chapter_complete": chapter_complete,
	}

func load_save_data(data: Dictionary) -> void:
	if data.is_empty():
		reset_chapter()
		return
	current_day = int(data.get("current_day", 1))
	max_days = int(data.get("max_days", MAX_DAYS))
	food = int(data.get("food", STARTING_NEED))
	water = int(data.get("water", STARTING_NEED))
	power = int(data.get("power", STARTING_NEED))
	chapter_failed = bool(data.get("chapter_failed", false))
	chapter_complete = bool(data.get("chapter_complete", false))

func _has_collapse() -> bool:
	return food < 0 or water < 0 or power < 0
