extends CanvasLayer
class_name MobileTouchControls

const MOVE_LEFT := &"move_left"
const MOVE_RIGHT := &"move_right"
const MOVE_UP := &"move_up"
const MOVE_DOWN := &"move_down"
const INTERACT := &"interact"
const SCAN := &"scan"
const BURST := &"burst_thruster"
const RESTART := &"restart_dive"
const MOVE_ACTIONS := [MOVE_LEFT, MOVE_RIGHT, MOVE_UP, MOVE_DOWN]
const BUTTON_ACTIONS := [SCAN, INTERACT, BURST, RESTART]
const JOYSTICK_RADIUS := 58.0
const JOYSTICK_KNOB_RADIUS := 24.0
const JOYSTICK_DEADZONE := 0.28
const BUTTON_SIZE := Vector2(76.0, 76.0)
const BUTTON_GAP := 10.0
const EDGE_MARGIN := 22.0
const BOTTOM_MARGIN := 24.0

@export var force_visible := false

var root_control: Control
var joystick_base: Panel
var joystick_knob: Panel
var joystick_label: Label
var button_root: Control
var active_touch_index := -1
var joystick_center := Vector2.ZERO
var active_action_states: Dictionary = {}
var action_buttons: Dictionary = {}

func _ready() -> void:
	layer = 80
	_build_controls()
	get_viewport().size_changed.connect(_layout_controls)
	visible = should_show_touch_controls()
	_layout_controls()

func should_show_touch_controls() -> bool:
	return force_visible or OS.has_feature("mobile") or _web_touch_available()

func _web_touch_available() -> bool:
	if not OS.has_feature("web") or not Engine.has_singleton("JavaScriptBridge"):
		return false
	var bridge := Engine.get_singleton("JavaScriptBridge")
	var result = bridge.eval("navigator.maxTouchPoints > 0 || 'ontouchstart' in window", true)
	return bool(result)

func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event is InputEventScreenTouch:
		_handle_screen_touch(event)
	elif event is InputEventScreenDrag:
		_handle_screen_drag(event)

func _exit_tree() -> void:
	_release_all_actions()

func _build_controls() -> void:
	root_control = Control.new()
	root_control.name = "TouchControlsRoot"
	root_control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root_control)

	joystick_base = _make_round_panel("MovePad", JOYSTICK_RADIUS * 2.0, Color(0.02, 0.12, 0.16, 0.42), Color(0.10, 0.86, 0.96, 0.36), 2)
	joystick_base.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root_control.add_child(joystick_base)

	joystick_knob = _make_round_panel("MoveKnob", JOYSTICK_KNOB_RADIUS * 2.0, Color(0.05, 0.92, 1.0, 0.58), Color(0.74, 1.0, 1.0, 0.42), 2)
	joystick_knob.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root_control.add_child(joystick_knob)

	joystick_label = Label.new()
	joystick_label.name = "MoveLabel"
	joystick_label.text = "MOVE"
	joystick_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	joystick_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	joystick_label.add_theme_color_override("font_color", Color(0.75, 1.0, 1.0, 0.70))
	joystick_label.add_theme_font_size_override("font_size", 11)
	joystick_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root_control.add_child(joystick_label)

	button_root = Control.new()
	button_root.name = "ActionButtons"
	button_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root_control.add_child(button_root)
	_add_action_button(SCAN, "SCAN")
	_add_action_button(INTERACT, "USE")
	_add_action_button(BURST, "BURST")
	_add_action_button(RESTART, "NEXT")

func _make_round_panel(panel_name: String, diameter: float, fill: Color, border: Color, border_width: int) -> Panel:
	var panel := Panel.new()
	panel.name = panel_name
	panel.custom_minimum_size = Vector2(diameter, diameter)
	panel.size = panel.custom_minimum_size
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.corner_radius_top_left = int(diameter * 0.5)
	style.corner_radius_top_right = int(diameter * 0.5)
	style.corner_radius_bottom_left = int(diameter * 0.5)
	style.corner_radius_bottom_right = int(diameter * 0.5)
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.30)
	style.shadow_size = 5
	panel.add_theme_stylebox_override("panel", style)
	return panel

func _add_action_button(action: StringName, label: String) -> void:
	var button := Button.new()
	button.name = "%sButton" % String(action).capitalize().replace(" ", "")
	button.text = label
	button.custom_minimum_size = BUTTON_SIZE
	button.size = BUTTON_SIZE
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_filter = Control.MOUSE_FILTER_STOP
	button.add_theme_font_size_override("font_size", 12)
	button.add_theme_color_override("font_color", Color(0.82, 1.0, 1.0, 0.92))
	button.add_theme_stylebox_override("normal", _make_button_style(Color(0.02, 0.12, 0.16, 0.48), Color(0.10, 0.86, 0.96, 0.32)))
	button.add_theme_stylebox_override("hover", _make_button_style(Color(0.04, 0.20, 0.26, 0.58), Color(0.30, 1.0, 1.0, 0.46)))
	button.add_theme_stylebox_override("pressed", _make_button_style(Color(0.05, 0.56, 0.68, 0.72), Color(0.74, 1.0, 1.0, 0.66)))
	button.button_down.connect(_set_action.bind(action, true))
	button.button_up.connect(_set_action.bind(action, false))
	button_root.add_child(button)
	action_buttons[action] = button

func _make_button_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.corner_radius_top_left = 10
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	style.content_margin_left = 8.0
	style.content_margin_right = 8.0
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.34)
	style.shadow_size = 5
	return style

func _layout_controls() -> void:
	var viewport := get_viewport()
	if viewport == null:
		return
	var viewport_size := Vector2(viewport.get_visible_rect().size)
	root_control.size = viewport_size

	joystick_center = Vector2(EDGE_MARGIN + JOYSTICK_RADIUS, viewport_size.y - BOTTOM_MARGIN - JOYSTICK_RADIUS)
	joystick_base.position = joystick_center - Vector2.ONE * JOYSTICK_RADIUS
	joystick_knob.position = joystick_center - Vector2.ONE * JOYSTICK_KNOB_RADIUS
	joystick_label.position = joystick_center + Vector2(-46.0, JOYSTICK_RADIUS + 2.0)
	joystick_label.size = Vector2(92.0, 18.0)

	var button_width := BUTTON_SIZE.x * 2.0 + BUTTON_GAP
	var button_height := BUTTON_SIZE.y * 2.0 + BUTTON_GAP
	var right_margin := EDGE_MARGIN
	var y_position := maxf(170.0, viewport_size.y - button_height - 182.0)
	button_root.position = Vector2(viewport_size.x - right_margin - button_width, y_position)
	button_root.size = Vector2(button_width, button_height)

	_position_button(SCAN, Vector2.ZERO)
	_position_button(INTERACT, Vector2(BUTTON_SIZE.x + BUTTON_GAP, 0.0))
	_position_button(BURST, Vector2(0.0, BUTTON_SIZE.y + BUTTON_GAP))
	_position_button(RESTART, Vector2(BUTTON_SIZE.x + BUTTON_GAP, BUTTON_SIZE.y + BUTTON_GAP))

func _position_button(action: StringName, local_position: Vector2) -> void:
	var button := action_buttons.get(action) as Button
	if button == null:
		return
	button.position = local_position

func _handle_screen_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		if active_touch_index == -1 and _joystick_hit_rect().has_point(event.position):
			active_touch_index = event.index
			_update_joystick(event.position)
	else:
		if event.index == active_touch_index:
			active_touch_index = -1
			_update_joystick(joystick_center)
			_release_move_actions()

func _handle_screen_drag(event: InputEventScreenDrag) -> void:
	if event.index != active_touch_index:
		return
	_update_joystick(event.position)

func _joystick_hit_rect() -> Rect2:
	var padding := Vector2(70.0, 84.0)
	return Rect2(joystick_base.position - padding * 0.5, joystick_base.size + padding)

func _update_joystick(pointer_position: Vector2) -> void:
	var offset := pointer_position - joystick_center
	var clamped_offset := offset.limit_length(JOYSTICK_RADIUS)
	joystick_knob.position = joystick_center + clamped_offset - Vector2.ONE * JOYSTICK_KNOB_RADIUS
	var normalized := clamped_offset / JOYSTICK_RADIUS
	_set_action(MOVE_LEFT, normalized.x < -JOYSTICK_DEADZONE)
	_set_action(MOVE_RIGHT, normalized.x > JOYSTICK_DEADZONE)
	_set_action(MOVE_UP, normalized.y < -JOYSTICK_DEADZONE)
	_set_action(MOVE_DOWN, normalized.y > JOYSTICK_DEADZONE)

func _set_action(action: StringName, pressed: bool) -> void:
	if bool(active_action_states.get(action, false)) == pressed:
		return
	active_action_states[action] = pressed
	var input_event := InputEventAction.new()
	input_event.action = action
	input_event.pressed = pressed
	input_event.strength = 1.0 if pressed else 0.0
	Input.parse_input_event(input_event)

func _release_move_actions() -> void:
	for action in MOVE_ACTIONS:
		_set_action(action, false)

func _release_all_actions() -> void:
	for action in MOVE_ACTIONS:
		_set_action(action, false)
	for action in BUTTON_ACTIONS:
		_set_action(action, false)
