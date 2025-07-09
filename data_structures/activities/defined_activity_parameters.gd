class_name DefinedActivityParameters
extends Resource

static func create_activity_parameters_from_parameters(_activity_name: String, _parameter_data_index: int, _max_time: int, _cash_change: int, _health_change: int, _health_max_change: int,  _stress_change: int, _stress_max_change:int,  _energy_change: int, _energy_max_change: int) -> ActivityParameters:
	var activity_parameters: ActivityParameters = ActivityParameters.new()
	activity_parameters.activity_name = _activity_name
	activity_parameters.parameter_data_index = _parameter_data_index
	activity_parameters.max_time = _max_time
	activity_parameters.cash_change = _cash_change
	activity_parameters.health_change = _health_change
	activity_parameters.stress_change = _stress_change
	activity_parameters.energy_change = _energy_change
	activity_parameters.health_max_change = _health_max_change
	activity_parameters.stress_max_change = _stress_max_change
	activity_parameters.energy_max_change = _energy_max_change
	return activity_parameters

static var work: ActivityParameters = create_activity_parameters_from_parameters("Work",0,8,3,0,0,1,0,-3,0)
static var sleep: ActivityParameters = create_activity_parameters_from_parameters("Sleep",1,8,0,1,0,-1,0,3,0)
static var cry: ActivityParameters = create_activity_parameters_from_parameters("Cry",2,8,0,0,0,1,0,-3,0)
static var tutorial_cry: ActivityParameters = create_activity_parameters_from_parameters("Cry",3,1,0,0,0,0,0,0,0)
static var baby_sleep: ActivityParameters = create_activity_parameters_from_parameters("Sleep",4,20,0,1,1,-1,1,3,1)
