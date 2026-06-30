class_name Area01VisualDirector
extends Node

const Area01SourceMapOverlayScript := preload("res://scripts/area01_source_map_overlay.gd")
const Area01VisualCueContractScript := preload("res://scripts/area01_visual_cue_contract.gd")

var source_map_overlay: Area01SourceMapOverlay = null

func ensure_source_map_overlay(host: Node) -> Area01SourceMapOverlay:
	if source_map_overlay != null and is_instance_valid(source_map_overlay):
		return source_map_overlay

	source_map_overlay = Area01SourceMapOverlayScript.new()
	host.add_child(source_map_overlay)
	return source_map_overlay

func sync_source_map_overlay(host: Node, scan_range: float, debug_visible: bool, overlay_requested: bool, capture_state: String, camera_state: String) -> Area01SourceMapOverlay:
	var overlay := ensure_source_map_overlay(host)
	overlay.scan_range = scan_range
	overlay.capture_state = capture_state
	overlay.camera_state = camera_state
	overlay.set_debug_visible(debug_visible and overlay_requested)
	return overlay

func source_map_overlay_visible() -> bool:
	return source_map_overlay != null and is_instance_valid(source_map_overlay) and source_map_overlay.visible

func cue_debug_report(root: Node, camera_region: Rect2 = Rect2()) -> Dictionary:
	return Area01VisualCueContractScript.debug_report(root, camera_region)
