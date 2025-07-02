class_name StressManager
extends Node

## Singleton pattern
static var ref: StressManager
func _init() -> void:
	if not ref: ref = self
	else: queue_free()

const utils = preload("res://scenes/singletons/utils/utils.gd")
var data: Data = Game.ref.data

signal stress_updated
#signal stress_created
#signal stress_consumed

func get_stress() -> int:
	return data.resources.stress

func gain_stress(quantity: int) -> Error:
	if quantity <= 0: 
		print_debug("StressManager: negative stress value encountered")
		return FAILED
	data.resources.stress += quantity
	if data.resources.stress + quantity > 100: 
		var error: Error = HealthManager.ref.lose_health(data.resources.stress + quantity - 100)
		if error != OK: return error
	stress_updated.emit()
	return OK

func lose_stress(quantity: int) -> Error:
	if quantity < 0: 
		print_debug("StressManager: negative stress value encountered")
		return FAILED
	if quantity >= data.resources.stress: data.resources.stress = 0
	else: data.resources.stress -= quantity
	stress_updated.emit()
	return OK

var _cycle_duration: float = 1.0
var _cycle_progression: float = 0.0
var _cycle_speed: float = 1.0
var _reduction_rate: int = 1

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _progress_cycle)

func _progress_cycle() -> void:
	_cycle_progression += _cycle_speed
	if _cycle_progression >= _cycle_duration:
		var error: Error = lose_stress(_reduction_rate)
		if error == OK: stress_updated.emit()
