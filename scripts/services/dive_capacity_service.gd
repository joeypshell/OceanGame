class_name DiveCapacityService
extends RefCounted

static func current_max_oxygen(
	base_max_oxygen: float,
	has_oxygen_tank_upgrade: bool,
	oxygen_tank_max_oxygen: float,
	oxygen_penalty: float
) -> float:
	var oxygen_max := base_max_oxygen
	if has_oxygen_tank_upgrade:
		oxygen_max = oxygen_tank_max_oxygen

	return maxf(12.0, oxygen_max - oxygen_penalty)

static func current_cargo_limit(
	base_cargo_limit: int,
	has_cargo_rack_upgrade: bool,
	cargo_rack_limit: int
) -> int:
	if has_cargo_rack_upgrade:
		return cargo_rack_limit

	return base_cargo_limit
