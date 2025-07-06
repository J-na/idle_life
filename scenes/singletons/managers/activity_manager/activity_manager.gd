class_name ActivityManager
extends Node

static var ref: ActivityManager ##Singleton reference

const utils = preload("res://scenes/singletons/utils/utils.gd")
var assign_amount: int = Game.ref.data.activities.assign_amount

func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

signal time_updated

func create_activity_parameters(_activity_name: String, _parameter_data_index: int, _max_time: int, _cash_change: int, _health_change: int, _stress_change: int,  _energy_change: int) -> ActivityParameters:
	var activity_parameters: ActivityParameters = ActivityParameters.new()
	activity_parameters.activity_name = _activity_name
	activity_parameters.parameter_data_index = _parameter_data_index
	activity_parameters.max_time = _max_time
	activity_parameters.cash_change = _cash_change
	activity_parameters.health_change = _health_change
	activity_parameters.stress_change = _stress_change
	activity_parameters.energy_change = _energy_change
	return activity_parameters

func change_assign_amount() -> void:
	if assign_amount == 4:
		assign_amount = 8
	elif assign_amount == 2:
		assign_amount = 4
	elif assign_amount == 1:
		assign_amount = 2
	else: 
		assign_amount = 1

func assign_time(activity: ActivitySlot) -> void:
	var error: Error = activity.assign_time(assign_amount)
	if error == OK: time_updated.emit()
	
func unassign_time(activity: ActivitySlot) -> void:
	var error: Error = activity.unassign_time(assign_amount)
	if error == OK: time_updated.emit()
