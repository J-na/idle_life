class_name ActivityManager
extends Node

static var ref: ActivityManager ##Singleton reference
func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

const utils = preload("res://scenes/singletons/utils/utils.gd")
const _activity_slot_component: PackedScene = preload("res://scenes/components/activity_slot/activity_slot.tscn")
var data: Data = Game.ref.data
var assign_amount: int = data.activities.assign_amount
signal time_updated

func create_new_activity_by_name(dict_id: String) -> ActivitySlot:
	var new_activity: ActivitySlot = _activity_slot_component.instantiate()
	new_activity.activity_id = get_activity_by_name(dict_id).internal_activity_id
	return new_activity
	
func set_activity_parameters_by_name(dict_id: String, _parameters_to_set: Dictionary) -> void:
	var _activity: ActivityParameters = get_activity_by_name(dict_id)
	var settable_parameters: Array[String]
	for property_info: Dictionary in _activity.get_property_list():
		settable_parameters.append(property_info["name"])
	for key: String in _parameters_to_set.keys():
		if key in settable_parameters:
			_activity[key] = _parameters_to_set[key]
	
func get_activity_by_name(dict_id: String) -> ActivityParameters:
	var activity_array: Array[ActivityParameters] = Game.ref.data.activities.activity_data_array
	var activity_reference_dict: Dictionary = Game.ref.data.activities.reference_activity_dict
	var live_activity: ActivityParameters = activity_array[activity_reference_dict[dict_id].internal_activity_id]
	return live_activity

func get_activity_by_id(array_index: int) -> ActivityParameters:
	var live_activity: ActivityParameters = Game.ref.data.activities.activity_data_array[array_index]
	return live_activity

func change_assign_amount() -> void:
	if assign_amount == 4:
		assign_amount = 8
	elif assign_amount == 2:
		assign_amount = 4
	elif assign_amount == 1:
		assign_amount = 2
	else: 
		assign_amount = 1
	
func assign_time(activity_id : int) -> void:
	var activity: ActivityParameters = get_activity_by_id(activity_id)
	if data.resources.available_hours >= assign_amount  and activity.assigned_time + assign_amount <= activity.max_time:
		activity.assigned_time += assign_amount
		data.resources.available_hours -= assign_amount
		_modify_generators(activity, "assign", assign_amount)
		time_updated.emit()

func unassign_time(activity_id: int) -> void:
	var activity: ActivityParameters = get_activity_by_id(activity_id)
	if activity.assigned_time >= assign_amount:
		activity.assigned_time -= assign_amount
		data.resources.available_hours += assign_amount
		_modify_generators(activity, "unassign",assign_amount)
		time_updated.emit()

func _modify_generators(activity: ActivityParameters, direction: String, amount: int) -> void:
	var polarity: int
	if direction == "assign":
		polarity = 1
	if direction == "unassign":
		polarity = -1
		
	data.resources.cash_generation += (int(polarity*amount*activity.cash_change))
	data.resources.health_generation += (int(polarity*amount*activity.health_change))
	data.resources.stress_generation += (int(polarity*amount*activity.stress_change))
	data.resources.energy_generation += (int(polarity*amount*activity.energy_change))
