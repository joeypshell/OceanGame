class_name SurfaceStatusPresenter
extends RefCounted

static func surface_oxygen_status_text(player_in_base: bool, oxygen: float, max_oxygen: float, interact_label: String) -> String:
	if player_in_base:
		return "Ship moonpool: O2 full; %s banks cargo." % interact_label
	if oxygen >= max_oxygen:
		return "Surface O2 full; ship still banks cargo."
	return "Surface O2 refilling; ship still banks cargo."

static func surface_oxygen_status_for_host(host) -> String:
	return surface_oxygen_status_text(
		host.player_in_base,
		host.dive_session.oxygen,
		host.dive_session.max_oxygen,
		host._action_label("interact")
	)

static func cargo_full_status_text(cargo_count: int, cargo_limit: int) -> String:
	return "Cargo full %d/%d: return to ship." % [cargo_count, cargo_limit]

static func cargo_full_status_for_host(host) -> String:
	return cargo_full_status_text(host.dive_session.current_cargo.size(), host.dive_session.cargo_limit)
