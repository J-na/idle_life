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

func get_stress() -> Array:
	return [data.resources.stress, data.resources.max_stress]

func change_stress(quantity: int) -> Error:
	var health_error: Error
	if data.resources.stress + quantity > data.resources.max_stress: 
		health_error = HealthManager.ref.change_hp(data.resources.max_stress - data.resources.stress - quantity )
		data.resources.stress = data.resources.max_stress
		print("over max stress")
	elif data.resources.stress + quantity < 0: 
		data.resources.stress = 0
		print("less than 0 stress %s" %quantity)
	else: 
		data.resources.stress += quantity
		print("stress added %s" %quantity)
	stress_updated.emit()
	return health_error

var _cycle_duration: float = 10
var _cycle_progression: float = 0.0
var _cycle_speed: float = 1.0
var _reduction_rate: int = 3

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _progress_cycle)

func _progress_cycle() -> void:
	_cycle_progression += _cycle_speed
	if _cycle_progression >= _cycle_duration:
		var error: Error = change_stress(-1*_reduction_rate)
		if error == OK: stress_updated.emit()
