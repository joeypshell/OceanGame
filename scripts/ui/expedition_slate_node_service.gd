class_name ExpeditionSlateNodeService
extends RefCounted

static func ensure_nodes(host) -> void:
	if host.expedition_slate_panel != null and is_instance_valid(host.expedition_slate_panel):
		return

	var hud: Node = host.get_node_or_null("HUD")
	if hud == null:
		return

	host.expedition_slate_panel = Panel.new()
	host.expedition_slate_panel.name = "ExpeditionSlatePanel"
	host.expedition_slate_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	host.expedition_slate_panel.visible = false
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.015, 0.055, 0.075, 0.9)
	panel_style.border_color = Color(0.16, 0.78, 0.9, 0.62)
	panel_style.border_width_left = 2
	panel_style.border_width_top = 2
	panel_style.border_width_right = 2
	panel_style.border_width_bottom = 2
	panel_style.corner_radius_top_left = 6
	panel_style.corner_radius_top_right = 6
	panel_style.corner_radius_bottom_left = 6
	panel_style.corner_radius_bottom_right = 6
	host.expedition_slate_panel.add_theme_stylebox_override("panel", panel_style)
	hud.add_child(host.expedition_slate_panel)

	host.expedition_slate_title_label = Label.new()
	host.expedition_slate_title_label.name = "Title"
	host.expedition_slate_title_label.text = "EXPEDITION SLATE"
	host.expedition_slate_title_label.modulate = Color(0.58, 1.0, 0.96, 0.96)
	host.expedition_slate_title_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	host.expedition_slate_panel.add_child(host.expedition_slate_title_label)

	host.expedition_slate_body_label = Label.new()
	host.expedition_slate_body_label.name = "Body"
	host.expedition_slate_body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	host.expedition_slate_body_label.clip_text = true
	host.expedition_slate_body_label.modulate = Color(0.86, 0.96, 1.0, 0.94)
	host.expedition_slate_body_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	host.expedition_slate_panel.add_child(host.expedition_slate_body_label)
