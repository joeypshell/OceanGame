class_name ToolBeltService
extends RefCounted

const ToolBeltPresenterScript := preload("res://scripts/ui/tool_belt_presenter.gd")

static func update_tool_belt(host, is_visible: bool) -> void:
	var tool_keys: Array[String] = ["F", "Space", "2", "3", "5"]
	for index in range(host.tool_slot_nodes.size()):
		var tool_id: String = host.TOOL_BELT_TOOL_IDS[index]
		var state: String = host._tool_belt_state(tool_id)
		host.tool_slot_nodes[index].visible = is_visible
		host.tool_icon_nodes[index].visible = is_visible
		host.tool_key_label_nodes[index].visible = is_visible
		host.tool_slot_nodes[index].color = ToolBeltPresenterScript.tool_slot_color(state)
		host.tool_icon_nodes[index].polygon = ToolBeltPresenterScript.tool_icon_polygon(tool_id)
		host.tool_icon_nodes[index].color = ToolBeltPresenterScript.tool_icon_color(tool_id, state)
		host.tool_key_label_nodes[index].text = tool_keys[index]
		host.tool_key_label_nodes[index].modulate = ToolBeltPresenterScript.tool_key_color(state)
