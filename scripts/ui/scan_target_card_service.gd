class_name ScanTargetCardService
extends RefCounted

const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")

static func update_card(host, target: Node) -> void:
	host.scan_card_title_label.text = "SCAN TARGET"
	if target == null:
		host.scan_target_label.text = "none nearby"
		host.scan_card_meta_label.text = "No readable signal"
		host.scan_card_prompt_label.text = "Hold %s near a target" % host._action_label("scan")
		return

	host.scan_target_label.text = ScanTargetResolverScript.display_name(target)
	host.scan_card_meta_label.text = "%s | %s" % [
		ScanFeedbackPresenterScript.format_scan_target_discovery_state(
			host.progression_state.has_discovery(ScanTargetResolverScript.target_id(target))
		).to_upper(),
		ScanFeedbackPresenterScript.format_scan_target_type(
			ScanTargetResolverScript.target_id(target),
			target is ResourcePickup
		).to_upper(),
	]
	if host.scan_charge_target == target:
		host.scan_card_prompt_label.text = "SCANNING %d%%" % int(roundf(ScanFeedbackPresenterScript.scan_charge_ratio(host.scan_charge_elapsed, host.scan_hold_seconds) * 100.0))
	else:
		host.scan_card_prompt_label.text = "HOLD %s TO SCAN" % host._action_label("scan")
