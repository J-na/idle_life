class_name EnergyManager
extends Node

## Singleton pattern
static var ref: EnergyManager
func _init() -> void:
	if not ref: ref = self
	else: queue_free()

const utils = preload("res://scenes/singletons/utils/utils.gd")
var data: Data = Game.ref.data

signal energy_updated
#signal energy_created
#signal energy_consumed

func get_energy() -> Array:
	return [data.resources.energy, data.resources.max_energy]

func change_energy(quantity: int) -> Error:
	var stress_error: Error
	if data.resources.energy + quantity < 0: 
		stress_error = StressManager.ref.change_stress(-1*(quantity + data.resources.energy))
		data.resources.energy = 0
	elif data.resources.energy + quantity > data.resources.max_energy: data.resources.energy = data.resources.max_energy
	else: data.resources.energy += quantity
	energy_updated.emit()
	return stress_error

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _activate_generation)

func _activate_generation() -> void:
	var error: Error = change_energy(data.resources.energy_generation)
	if error == OK: energy_updated.emit()
