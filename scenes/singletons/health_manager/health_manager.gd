class_name HealthManager
extends Node

const utils = preload("res://scenes/singletons/utils/utils.gd")

## Singleton pattern
static var ref: HealthManager
func _init() -> void:
	if not ref: ref = self
	else: queue_free()
	
signal health_updated
#signal health_created
#signal health_consumed

var data: Data = Game.ref.data

func get_health() -> int:
	return data.resources.health

func gain_health(quantity: int) -> Error:
	if quantity <= 0: return FAILED
	if data.resources.health + quantity > 100: return FAILED
	data.resources.health += quantity
	health_updated.emit()
	return OK

func lose_health(quantity: int) -> Error:
	if quantity < 0: return FAILED
	if quantity > data.resources.health: print_debug("you died")
	data.resources.health -= quantity
	health_updated.emit()
	return OK

var _cycle_duration: float = 10.0
var _cycle_progression: float = 0.0
var _cycle_speed: float = 1.0
var _regeneration_amount: int = 1

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _progress_cycle)

func _progress_cycle() -> void:
	_cycle_progression += _cycle_speed
	if _cycle_progression >= _cycle_duration:
		var error: Error = lose_health(_regeneration_amount)
		if error == OK: health_updated.emit()
