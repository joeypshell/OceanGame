class_name DiveSession
extends RefCounted

enum Result { READY, DIVING, EXTRACTED, FAILED }

var max_oxygen := 30.0
var oxygen := 30.0
var max_health := 100.0
var health := 100.0
var current_cargo: Array[String] = []
var cargo_limit := 3
var has_left_base := false
var current_depth := 0.0
var result := Result.DIVING
var unlimited_oxygen := false

func reset(new_max_oxygen: float, new_max_health: float = 100.0) -> void:
	max_oxygen = new_max_oxygen
	oxygen = max_oxygen
	max_health = maxf(1.0, new_max_health)
	health = max_health
	current_cargo.clear()
	has_left_base = false
	current_depth = 0.0
	result = Result.READY

func start() -> void:
	result = Result.DIVING

func drain_oxygen(amount: float) -> void:
	if result != Result.DIVING:
		return
	if unlimited_oxygen:
		return

	oxygen = maxf(0.0, oxygen - amount)
	if oxygen <= 0.0:
		fail()

func refill_oxygen(amount: float) -> void:
	if result != Result.DIVING:
		return
	if amount <= 0.0:
		return

	oxygen = minf(max_oxygen, oxygen + amount)

func damage_health(amount: float) -> void:
	if result != Result.DIVING:
		return
	if amount <= 0.0:
		return

	health = maxf(0.0, health - amount)
	if health <= 0.0:
		fail()

func can_extract(player_in_base: bool) -> bool:
	return result == Result.DIVING and player_in_base and has_left_base

func extract() -> void:
	result = Result.EXTRACTED

func fail() -> void:
	current_cargo.clear()
	result = Result.FAILED

func clear_cargo() -> void:
	current_cargo.clear()

func add_cargo(resource_id: String) -> bool:
	if current_cargo.size() >= cargo_limit:
		return false

	current_cargo.append(resource_id)
	return true
