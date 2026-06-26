class_name ScanPulseVisual
extends RefCounted

static func idle_modulate() -> Color:
	return Color.WHITE

static func selected_modulate() -> Color:
	return Color(1.35, 1.25, 0.58, 1.0)

static func tactical_highlight_modulate(ticks_msec: int) -> Color:
	var pulse := 0.5 + 0.5 * absf(sin(ticks_msec / 120.0))
	return Color(
		0.72 + 0.18 * pulse,
		1.22 + 0.28 * pulse,
		0.82 + 0.12 * pulse,
		1.0
	)
