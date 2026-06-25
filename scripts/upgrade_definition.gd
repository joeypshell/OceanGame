class_name UpgradeDefinition
extends Resource

@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var resource_cost: Dictionary = {}
@export var required_discovery: String
@export var required_upgrade: String
@export var effect_id: String
@export_multiline var locked_reason: String
@export_multiline var available_text: String
@export_multiline var owned_text: String
