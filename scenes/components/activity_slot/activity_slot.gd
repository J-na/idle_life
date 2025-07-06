class_name ActivitySlot
extends MarginContainer

var data: Data = Game.ref.data
var _parameters: ActivityParameters 

const _activity_slot_component: PackedScene = preload("res://scenes/components/activity_slot/activity_slot.tscn")
const utils = preload("res://scenes/singletons/utils/utils.gd")

func _ready() -> void:
	utils.error_aware_connector((%AssignTimeButton as Button).pressed, ActivityManager.ref.assign_time.bind(self))
	utils.error_aware_connector((%UnassignTimeButton as Button).pressed, ActivityManager.ref.unassign_time.bind(self))
	_update_property_label()
	_update_time_label()
	
func set_parameters(parameters: ActivityParameters) -> void:
	_parameters = parameters
	if parameters.parameter_data_index >= data.activities.activity_states.size():
		data.activities.activity_states.append(parameters)
		print_debug("activity initialized")
	_update_property_label()
	_update_time_label()

func save_parameters() -> void:
	data.activities.activity_states[_parameters.parameter_data_index] = _parameters

func _update_time_label() -> void:
	(%ActivityTimeLabel as Label).text = "%s: %s hours" %[_parameters.activity_name, _parameters.assigned_time]

func _update_property_label() -> void:
	(%ActivityPropertyLabel as Label).text = "Cash: %s, health: %s, stress: %s, energy: %s" %[_parameters.cash_change, _parameters.health_change, _parameters.stress_change, _parameters.energy_change]

func update_button_labels() -> void:
	(%AssignTimeButton as Button).text = "+%s" %ActivityManager.ref.assign_amount
	(%UnassignTimeButton as Button).text = "-%s" %ActivityManager.ref.assign_amount

func assign_time(amount: int) -> Error:
	if data.resources.available_hours >= amount  and _parameters.assigned_time + amount <= _parameters.max_time:
		_parameters.assigned_time += amount
		data.resources.available_hours -= amount
		save_parameters()
		modify_generators("assign", amount)
		_update_time_label()
		_update_property_label()
		return OK
	else: 
		return FAILED

func unassign_time(amount: int) -> Error:
	if _parameters.assigned_time >= amount:
		_parameters.assigned_time -= amount
		data.resources.available_hours += amount
		save_parameters()
		modify_generators("unassign",amount)
		_update_time_label()
		_update_property_label()
		return OK
	else: return FAILED

func modify_generators(direction: String, amount: int) -> void:
	var polarity: int
	if direction == "assign":
		polarity = 1
	if direction == "unassign":
		polarity = -1
		
	data.resources.cash_generation += (int(polarity*amount*_parameters.cash_change))
	data.resources.health_generation += (int(polarity*amount*_parameters.health_change))
	data.resources.stress_generation += (int(polarity*amount*_parameters.stress_change))
	data.resources.energy_generation += (int(polarity*amount*_parameters.energy_change))

static func create_new_activity(parameters: ActivityParameters) -> ActivitySlot:
	var new_activity: ActivitySlot = _activity_slot_component.instantiate()
	new_activity.set_parameters(parameters)
	return new_activity
