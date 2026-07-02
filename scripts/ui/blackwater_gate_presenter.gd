class_name BlackwaterGatePresenter
extends RefCounted

static func format_gate_status(is_gate_open: bool, has_echo_lens: bool) -> String:
	if is_gate_open:
		return "Blackwater: trace sill. Return Silt/Blue/Drop."
	if has_echo_lens:
		return "Blackwater Crack sealed. Resonance Key I preparation needed."

	return "Blackwater Crack sealed. Echo Lens study and Resonance Key I preparation needed."

static func format_prompt(is_gate_open: bool, trace_recovered: bool, interact_label: String) -> String:
	if is_gate_open:
		if trace_recovered:
			return "Blackwater Sill: trace recorded - return via Silt/Blue"

		return "Blackwater Sill: %s record trace" % interact_label

	return "Blackwater Crack: %s read Resonance seal" % interact_label
