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

func get_hp() -> Array:
	return [data.resources.hp, data.resources.max_hp]

func change_hp(quantity: int) -> Error:
	if data.resources.hp + quantity > data.resources.max_hp: return FAILED
	data.resources.hp += quantity
	health_updated.emit()
	if data.resources.hp < 0: 
		data.resources.hp = 0
		print("You died!")
	return OK
	
func change_max_hp(quantity: int) -> Error:
	data.resources.max_hp += quantity
	data.resources.hp += quantity
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
		var error: Error = change_hp(_regeneration_amount)
		if error == OK: health_updated.emit()
