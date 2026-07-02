class_name RunPanelLayoutService
extends RefCounted

static func apply_layout(host, use_compact_panel: bool) -> void:
	var rect: Rect2 = host.RUN_PANEL_COMPACT_RECT if use_compact_panel else host.RUN_PANEL_TALL_RECT
	host.run_panel.offset_left = rect.position.x
	host.run_panel.offset_top = rect.position.y
	host.run_panel.offset_right = rect.position.x + rect.size.x
	host.run_panel.offset_bottom = rect.position.y + rect.size.y

	var content_right: float = host.RUN_PANEL_CONTENT_RIGHT_COMPACT if use_compact_panel else host.RUN_PANEL_CONTENT_RIGHT_TALL
	host.surface_tabs_label.offset_right = content_right
	host.run_title_label.offset_right = content_right
	host.run_summary_label.offset_right = content_right
	host.run_summary_label.offset_bottom = host.RUN_SUMMARY_COMPACT_BOTTOM if use_compact_panel else host.RUN_SUMMARY_TALL_BOTTOM
