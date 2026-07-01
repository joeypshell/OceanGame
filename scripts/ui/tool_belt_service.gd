class_name ToolBeltService
extends RefCounted

const ToolBeltPresenterScript := preload("res://scripts/ui/tool_belt_presenter.gd")

static func update_tool_belt(host, is_visible: bool) -> void:
	var tool_keys: Array[String] = ["F", "Space", "2", "3", "5"]
	for index in range(host.tool_slot_nodes.size()):
		var tool_id: String = host.TOOL_BELT_TOOL_IDS[index]
		var state: String = tool_belt_state(
			tool_id,
			host.current_scan_target != null,
			host.burst_thruster_cooldown_remaining,
			host.dive_session.oxygen,
			host.burst_thruster_oxygen_cost,
			host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID),
			host.progression_state.has_upgrade(host.DECOY_PULSE_UPGRADE_ID),
			host.decoy_pulse_used_this_run
		)
		host.tool_slot_nodes[index].visible = is_visible
		host.tool_icon_nodes[index].visible = is_visible
		host.tool_key_label_nodes[index].visible = is_visible
		host.tool_slot_nodes[index].color = ToolBeltPresenterScript.tool_slot_color(state)
		host.tool_icon_nodes[index].polygon = ToolBeltPresenterScript.tool_icon_polygon(tool_id)
		host.tool_icon_nodes[index].color = ToolBeltPresenterScript.tool_icon_color(tool_id, state)
		host.tool_key_label_nodes[index].text = tool_keys[index]
		host.tool_key_label_nodes[index].modulate = ToolBeltPresenterScript.tool_key_color(state)

static func tool_belt_state(
	tool_id: String,
	has_scan_target: bool,
	burst_cooldown_remaining: float,
	oxygen: float,
	burst_oxygen_cost: float,
	has_salvage_cutter: bool,
	has_decoy_pulse: bool,
	decoy_used_this_run: bool
) -> String:
	match tool_id:
		"scanner":
			return "active" if has_scan_target else "ready"
		"burst":
			if burst_cooldown_remaining > 0.0:
				return "cooldown"
			return "ready" if oxygen > burst_oxygen_cost else "disabled"
		"cutter":
			return "ready" if has_salvage_cutter else "locked"
		"decoy":
			if not has_decoy_pulse:
				return "locked"
			return "spent" if decoy_used_this_run else "ready"
		"reserve":
			return "locked"
		_:
			return "disabled"
