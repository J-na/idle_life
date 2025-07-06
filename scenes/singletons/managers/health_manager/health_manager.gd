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

func get_health() -> Array:
	return [data.resources.health, data.resources.max_health]

func change_health(quantity: int) -> Error:
	if data.resources.health + quantity > data.resources.max_health: return FAILED
	data.resources.health += quantity
	health_updated.emit()
	if data.resources.health < 0: 
		data.resources.health = 0
		print("You died!")
	return OK
	
func change_max_health(quantity: int) -> Error:
	data.resources.max_health += quantity
	data.resources.health += quantity
	health_updated.emit()
	return OK

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _activate_generation)

func _activate_generation() -> void:
	var error: Error = change_health(data.resources.health_generation)
	if error == OK: health_updated.emit()
