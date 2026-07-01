class_name SaveService
extends RefCounted

static func load_progression(path: String, progression_state: ProgressionState, survival_state: SurvivalState) -> bool:
	if not FileAccess.file_exists(path):
		return false

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_warning("Could not open progression save.")
		return false

	var parsed = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary:
		return false

	progression_state.load_save_data(parsed)
	survival_state.load_save_data(parsed.get("survival_state", {}))
	return true

static func save_progression(path: String, progression_state: ProgressionState, survival_state: SurvivalState) -> bool:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_warning("Could not write progression save.")
		return false

	var save_data := progression_state.to_save_data()
	save_data["survival_state"] = survival_state.to_save_data()
	file.store_string(JSON.stringify(save_data, "\t"))
	return true

static func delete_progression_save(path: String) -> bool:
	if not FileAccess.file_exists(path):
		return true

	var base_dir := path.get_base_dir()
	var file_name := path.get_file()
	var save_dir := DirAccess.open(base_dir)
	if save_dir == null:
		push_warning("Could not open user save directory to reset progression.")
		return false

	var error := save_dir.remove(file_name)
	if error != OK:
		push_warning("Could not delete progression save; clean save will be overwritten.")
		return false

	return true
