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
		health_error = HealthManager.ref.change_health(data.resources.max_stress - data.resources.stress - quantity )
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

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _activate_generation)

func _activate_generation() -> void:
	var error: Error = change_stress(data.resources.stress_generation)
	if error == OK: stress_updated.emit()
