class_name UpgradeEffectService
extends RefCounted

static func apply_upgrade_effect(host, effect_id: String) -> void:
	match effect_id:
		"max_oxygen_40":
			pass
		"open_pressure_wreck":
			host._sync_pressure_lock_state()
			host._sync_wreck_echo_state()
		"resource_signal_pulse":
			pass
		"echo_lens_wreck_echo":
			host._sync_wreck_echo_state()
			host._sync_sealed_shelf_hatch_state()
			host._sync_blackwater_crack_gate_state()
		"resonance_key_1":
			host._sync_sealed_shelf_hatch_state()
			host._sync_blackwater_crack_gate_state()
		"cargo_limit_4":
			host.dive_session.cargo_limit = host._current_cargo_limit()
		"water_reserve_1":
			host.survival_state.water += 1
		"predator_warning_range_1":
			host._sync_predator_warning_upgrade_state()
		"decoy_pulse_1":
			pass
		"salvage_cutter_1":
			host._sync_salvage_pocket_open_state()
		_:
			push_warning("Unknown upgrade effect: %s" % effect_id)
