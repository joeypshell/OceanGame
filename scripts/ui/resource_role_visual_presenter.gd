class_name ResourceRoleVisualPresenter
extends RefCounted

static func ensure_resource_role_visual(pickup: Node2D, resource_id: String, role_family: String, accent: Color) -> void:
	var role_read := pickup.get_node_or_null("RoleRead") as Node2D
	if role_read == null:
		role_read = Node2D.new()
		role_read.name = "RoleRead"
		pickup.add_child(role_read)
	role_read.visible = true
	role_read.position = Vector2(0.0, -32.0)
	role_read.scale = Vector2(1.35, 1.35)
	role_read.z_index = 2
	role_read.set_meta("role_family", role_family)
	role_read.set_meta("resource_id", resource_id)
	if role_read.get_child_count() > 0:
		return

	_add_role_polygon(role_read, "BadgeShadow", [
		Vector2(-16.0, -12.0),
		Vector2(16.0, -12.0),
		Vector2(16.0, 12.0),
		Vector2(-16.0, 12.0),
	], Color(0.012, 0.028, 0.036, 0.82))
	_add_role_polygon(role_read, "BadgeRim", [
		Vector2(-13.0, -10.0),
		Vector2(13.0, -10.0),
		Vector2(13.0, 10.0),
		Vector2(-13.0, 10.0),
	], Color(0.88, 1.0, 1.0, 0.28))
	match role_family:
		"supply":
			_add_supply_role_badge(role_read, accent)
		"building":
			_add_building_role_badge(role_read, accent)
		_:
			_add_research_role_badge(role_read, accent)

static func _add_supply_role_badge(parent: Node2D, accent: Color) -> void:
	_add_role_polygon(parent, "SupplyBadge", [
		Vector2(-10.0, -6.0),
		Vector2(-2.0, -10.0),
		Vector2(9.0, -7.0),
		Vector2(11.0, 2.0),
		Vector2(4.0, 9.0),
		Vector2(-8.0, 7.0),
		Vector2(-12.0, -1.0),
	], Color(0.98, 0.58, 0.13, 0.84))
	_add_role_polygon(parent, "SupplyPip", [
		Vector2(-3.0, -4.0),
		Vector2(5.0, -4.0),
		Vector2(6.0, 4.0),
		Vector2(-4.0, 5.0),
	], accent)

static func _add_building_role_badge(parent: Node2D, accent: Color) -> void:
	_add_role_polygon(parent, "BuildingBlock", [
		Vector2(-10.0, -8.0),
		Vector2(9.0, -8.0),
		Vector2(11.0, 7.0),
		Vector2(-8.0, 9.0),
	], Color(0.43, 0.50, 0.54, 0.88))
	_add_role_polygon(parent, "BuildingSash", [
		Vector2(-7.0, 1.0),
		Vector2(4.0, -7.0),
		Vector2(8.0, -3.0),
		Vector2(-3.0, 6.0),
	], accent)

static func _add_research_role_badge(parent: Node2D, accent: Color) -> void:
	_add_role_polygon(parent, "ResearchDiamond", [
		Vector2(0.0, -11.0),
		Vector2(10.0, 0.0),
		Vector2(0.0, 11.0),
		Vector2(-10.0, 0.0),
	], Color(0.20, 0.90, 1.0, 0.78))
	_add_role_polygon(parent, "ResearchCore", [
		Vector2(0.0, -5.0),
		Vector2(5.0, 0.0),
		Vector2(0.0, 5.0),
		Vector2(-5.0, 0.0),
	], accent)

static func _add_role_polygon(parent: Node2D, polygon_name: String, points: Array[Vector2], color: Color) -> void:
	var polygon := Polygon2D.new()
	polygon.name = polygon_name
	polygon.polygon = PackedVector2Array(points)
	polygon.color = color
	parent.add_child(polygon)
