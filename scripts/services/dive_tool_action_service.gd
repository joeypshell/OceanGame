class_name DiveToolActionService
extends RefCounted

static func try_burst_thruster(host) -> void:
	if host.player == null:
		host.player = host.get_node_or_null("Player") as CharacterBody2D
	if host.has_method("_ensure_active_hud_references"):
		host._ensure_active_hud_references()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return
	if host.player == null:
		return

	if host.burst_thruster_cooldown_remaining > 0.0:
		host.status_label.text = "Burst Thruster cooling down: %ds." % ceili(host.burst_thruster_cooldown_remaining)
		host._update_hud()
		return

	if not host.dive_session.unlimited_oxygen and host.dive_session.oxygen <= host.burst_thruster_oxygen_cost:
		host.status_label.text = "Burst Thruster needs more than %d oxygen." % ceili(host.burst_thruster_oxygen_cost)
		host._update_hud()
		return

	var burst_direction: Vector2 = host.player.get_burst_direction()
	host.player.burst(burst_direction, host.burst_thruster_force)
	host.dive_session.drain_oxygen(host.burst_thruster_oxygen_cost)
	host.burst_thruster_cooldown_remaining = host.burst_thruster_cooldown_seconds
	host.status_label.text = "Burst Thruster: %s Cooldown started." % ("debug oxygen unchanged." if host.dive_session.unlimited_oxygen else "-%d oxygen." % ceili(host.burst_thruster_oxygen_cost))
	host._update_hud()
