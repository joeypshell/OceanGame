class_name WreckEchoVisualStagingService
extends RefCounted

static func stage_visual_review(host) -> void:
	if not host.show_debug_telemetry:
		return

	host.progression_state.purchased_upgrades[host.SIGNAL_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.PRESSURE_SEAL_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	if host.pressure_boundary != null:
		host._sync_pressure_lock_state()
	host._sync_wreck_echo_state()

	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.debug_wreck_echo_review_staged:
		if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
			host.dive_session.start()
		var trigger := host.wreck_echo_clue_trigger
		if trigger == null:
			trigger = host.get_node_or_null("WreckEchoDescent/ClueTrigger") as Area2D
		if trigger == null:
			return
		var staged_player = host.player
		if staged_player == null:
			staged_player = host.get_node_or_null("Player") as CharacterBody2D
		if staged_player == null:
			return
		host.player = staged_player
		host.player.global_position = trigger.global_position + Vector2(-95.0, -34.0)
		host.player.velocity = Vector2.ZERO
		host.dive_session.has_left_base = true
		host.debug_wreck_echo_review_staged = true
		if host.status_label != null:
			host.status_label.text = "Debug review: Wreck Echo route staged."
		host._update_depth()
		if host.is_inside_tree():
			host._update_hud()
		return

	host.run_wreck_echo_clue_recovered = true
	host._sync_wreck_echo_state()
	var review_base := host.base_zone
	if review_base == null:
		review_base = host.get_node_or_null("BaseZone") as Area2D
	if host.player == null:
		host.player = host.get_node_or_null("Player") as CharacterBody2D
	if review_base == null or host.player == null:
		return
	host.base_zone = review_base
	host.player.global_position = host.base_zone.global_position
	host.player.velocity = Vector2.ZERO
	host.player_in_base = true
	if not host.is_inside_tree():
		host.dive_session.extract()
		host.last_result_summary = host._format_wreck_echo_research_callout()
		return
	host._try_extract()
