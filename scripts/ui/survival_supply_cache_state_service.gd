class_name SurvivalSupplyCacheStateService
extends RefCounted

static func sync_state(host) -> void:
	if host.survival_supply_cache_halo == null or host.survival_supply_cache_core == null:
		return

	if host.run_survival_supply_cache_recovered:
		host.survival_supply_cache_halo.color = Color(0.72, 0.95, 1.0, 0.08)
		host.survival_supply_cache_core.color = Color(0.96, 0.78, 0.38, 0.18)
		if host.survival_supply_cache_label != null:
			host.survival_supply_cache_label.text = "SUPPLY TAKEN"
	else:
		host.survival_supply_cache_halo.color = Color(0.72, 0.95, 1.0, 0.22)
		host.survival_supply_cache_core.color = Color(0.96, 0.78, 0.38, 0.72)
		if host.survival_supply_cache_label != null:
			host.survival_supply_cache_label.text = "SUPPLY CACHE"
