class_name DataActivities
extends Resource

@export var assign_amount: int = 1

static func _create_activity_parameters_from_parameters(_activity_name: String, _internal_activity_id:int, _max_time: int, _cash_change: int, _health_change: int, _health_max_change: int,  _stress_change: int, _stress_max_change:int,  _energy_change: int, _energy_max_change: int) -> ActivityParameters:
	var activity_parameters: ActivityParameters = ActivityParameters.new()
	activity_parameters.activity_name = _activity_name
	activity_parameters.internal_activity_id= _internal_activity_id
	activity_parameters.max_time = _max_time
	activity_parameters.cash_change = _cash_change
	activity_parameters.health_change = _health_change
	activity_parameters.stress_change = _stress_change
	activity_parameters.energy_change = _energy_change
	activity_parameters.health_max_change = _health_max_change
	activity_parameters.stress_max_change = _stress_max_change
	activity_parameters.energy_max_change = _energy_max_change
	return activity_parameters

@export var activity_data_array: Array[ActivityParameters] = [
_create_activity_parameters_from_parameters("cry",0,1,0,0,0,0,0,0,0),
_create_activity_parameters_from_parameters("sleep",1,20,0,1,1,-1,1,3,1),
_create_activity_parameters_from_parameters("cry",2,8,0,0,0,1,0,-3,0),
_create_activity_parameters_from_parameters("sleep",3,8,0,1,0,-1,0,3,0),
_create_activity_parameters_from_parameters("work",4,8,3,0,0,1,0,-3,0),
]

@export var reference_activity_dict: Dictionary = { 
	"tutorial cry": activity_data_array[0],
	"baby sleep": activity_data_array[1],
	"cry": activity_data_array[2],
	"work": activity_data_array[3], 
	"sleep": activity_data_array[4], 
	}
