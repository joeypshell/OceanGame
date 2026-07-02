class_name MainReadyService
extends RefCounted

const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")
const ResourcePickupPresentationServiceScript := preload("res://scripts/ui/resource_pickup_presentation_service.gd")
const RouteProximityServiceScript := preload("res://scripts/services/route_proximity_service.gd")
const SceneEventServiceScript := preload("res://scripts/services/scene_event_service.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")

static func ready(host) -> void:
	var area01_build := Area01BlockoutBuilderScript.new()
	if not area01_build.build(host):
		push_warning("Area 01 blockout authority failed: %s" % area01_build.last_error)
	host._ensure_area01_source_map_overlay()
	host._ensure_mobile_touch_controls()
	host._wire_surface_oxygen_refill_zone()
	_connect_once(host.base_zone, "body_entered", Callable(RouteProximityServiceScript, "on_base_zone_body_entered").bind(host))
	_connect_once(host.base_zone, "body_exited", Callable(RouteProximityServiceScript, "on_base_zone_body_exited").bind(host))
	_connect_once(host.survival_supply_cache_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_survival_supply_cache_body_entered").bind(host))
	_connect_once(host.survival_supply_cache_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_survival_supply_cache_body_exited").bind(host))
	_connect_once(host.east_shelf_pocket_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_east_shelf_pocket_body_entered").bind(host))
	_connect_once(host.east_shelf_pocket_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_east_shelf_pocket_body_exited").bind(host))
	_connect_once(host.lower_connector_echo_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_lower_connector_echo_body_entered").bind(host))
	_connect_once(host.lower_connector_echo_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_lower_connector_echo_body_exited").bind(host))
	_connect_once(host.resonance_alcove_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_resonance_alcove_body_entered").bind(host))
	_connect_once(host.resonance_alcove_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_resonance_alcove_body_exited").bind(host))
	_connect_once(host.blue_chimney_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_blue_chimney_body_entered").bind(host))
	_connect_once(host.blue_chimney_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_blue_chimney_body_exited").bind(host))
	_connect_once(host.lantern_silt_nook_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_lantern_silt_nook_body_entered").bind(host))
	_connect_once(host.lantern_silt_nook_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_lantern_silt_nook_body_exited").bind(host))
	_connect_once(host.blackwater_crack_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_blackwater_crack_body_entered").bind(host))
	_connect_once(host.blackwater_crack_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_blackwater_crack_body_exited").bind(host))
	_connect_once(host.glass_kelp_ledge_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_glass_kelp_ledge_body_entered").bind(host))
	_connect_once(host.glass_kelp_ledge_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_glass_kelp_ledge_body_exited").bind(host))
	_connect_once(host.hollow_reef_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_hollow_reef_body_entered").bind(host))
	_connect_once(host.hollow_reef_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_hollow_reef_body_exited").bind(host))
	_connect_once(host.salvage_manifest_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_salvage_manifest_body_entered").bind(host))
	_connect_once(host.salvage_manifest_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_salvage_manifest_body_exited").bind(host))
	_connect_once(host.salvage_data_cache_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_salvage_data_cache_body_entered").bind(host))
	_connect_once(host.salvage_data_cache_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_salvage_data_cache_body_exited").bind(host))
	_connect_once(host.outer_shelf_survey_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_outer_shelf_survey_body_entered").bind(host))
	_connect_once(host.outer_shelf_survey_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_outer_shelf_survey_body_exited").bind(host))
	_connect_once(host.rim_glass_reading_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_rim_glass_reading_body_entered").bind(host))
	_connect_once(host.rim_glass_reading_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_rim_glass_reading_body_exited").bind(host))
	_connect_once(host.tideglass_sample_interact_zone, "body_entered", Callable(RouteProximityServiceScript, "on_tideglass_sample_body_entered").bind(host))
	_connect_once(host.tideglass_sample_interact_zone, "body_exited", Callable(RouteProximityServiceScript, "on_tideglass_sample_body_exited").bind(host))
	if host.thermal_vent_hazard != null:
		_connect_once(host.thermal_vent_hazard, "body_entered", Callable(SceneEventServiceScript, "on_thermal_vent_hazard_body_entered").bind(host))
	_connect_once(host.pressure_boundary, "body_entered", Callable(SceneEventServiceScript, "on_pressure_boundary_body_entered").bind(host))
	_connect_once(host.wreck_echo_clue_trigger, "body_entered", Callable(SceneEventServiceScript, "on_wreck_echo_clue_body_entered").bind(host))
	for pickup in host.get_tree().get_nodes_in_group("resource_pickups"):
		_connect_once(pickup, "collected", Callable(SceneEventServiceScript, "on_resource_pickup_collected").bind(host))
	ResourcePickupPresentationServiceScript.ensure_resource_role_visuals(host)
	for predator in host.get_tree().get_nodes_in_group("predators"):
		_connect_once(predator, "contacted", Callable(SceneEventServiceScript, "on_predator_contacted").bind(host))
	SaveServiceScript.load_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	host._prepare_next_run()
	host._sync_debug_oxygen_mode()
	host._sync_discovery_reveals()
	host._sync_salvage_pocket_open_state()
	host._sync_area01_source_map_overlay()
	host._sync_surface_oxygen_refill_state_from_position()
	host._update_hud()

static func _connect_once(emitter: Object, signal_name: StringName, callback: Callable) -> void:
	if emitter == null:
		return
	if emitter.is_connected(signal_name, callback):
		return
	emitter.connect(signal_name, callback)
