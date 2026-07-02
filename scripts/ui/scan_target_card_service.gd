class_name ScanTargetCardService
extends RefCounted

static func update_card(host, target: Node) -> void:
	host.scan_card_title_label.text = "SCAN TARGET"
	if target == null:
		host.scan_target_label.text = "none nearby"
		host.scan_card_meta_label.text = "No readable signal"
		host.scan_card_prompt_label.text = "Hold %s near a target" % host._action_label("scan")
		return

	host.scan_target_label.text = host._scan_target_display_name(target)
	host.scan_card_meta_label.text = "%s | %s" % [
		host._format_scan_target_discovery_state(target).to_upper(),
		host._format_scan_target_type(target).to_upper(),
	]
	if host.scan_charge_target == target:
		host.scan_card_prompt_label.text = "SCANNING %d%%" % int(roundf(ScanFeedbackPresenterScript.scan_charge_ratio(host.scan_charge_elapsed, host.scan_hold_seconds) * 100.0))
	else:
		host.scan_card_prompt_label.text = "HOLD %s TO SCAN" % host._action_label("scan")
