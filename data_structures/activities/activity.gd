class_name Activity
extends Resource

var _parameters: ActivityParameters
var data: Data = Game.ref.data
const utils = preload("res://scenes/singletons/utils/utils.gd")

func _init(parameter_data_index: int, cash_change: int, hp_change: int, stress_change: int, energy_change: int) -> void:
	if parameter_data_index < data.activities.activity_states.size():
		_parameters = data.activities.activity_states[parameter_data_index]
		print("activity loaded")
	else:
		_parameters = ActivityParameters.new()
		_parameters.cash_change = cash_change
		_parameters.hp_change = hp_change
		_parameters.stress_change = stress_change
		_parameters.energy_change = energy_change
		_parameters.parameter_data_index = parameter_data_index
		data.activities.activity_states.append(_parameters)
		print_debug("activity initialized")
	utils.error_aware_connector(Clock.ref.tick, _progress_cycle)

func save_parameters() -> void:
	data.activities.activity_states[_parameters.parameter_data_index] = _parameters

func assign_time() -> Error:
	if data.resources.available_hours > 0 and _parameters.assigned_time < _parameters.max_time:
		_parameters.assigned_time += 1
		data.resources.available_hours -= 1
		save_parameters()
		return OK
	else: 
		return FAILED

func unassign_time() -> Error:
	if _parameters.assigned_time > 0:
		_parameters.assigned_time -= 1
		data.resources.available_hours += 1
		save_parameters()
		return OK
	else: return FAILED

func _progress_cycle() -> void:
	var _cash_error: Error = CashManager.ref.change_cash(int(_parameters.assigned_time*_parameters.cash_change))
	var _health_error: Error = HealthManager.ref.change_hp(int(_parameters.assigned_time*_parameters.hp_change))
	var _stress_error: Error = StressManager.ref.change_stress(int(_parameters.assigned_time*_parameters.stress_change))
	var _energy_error: Error = EnergyManager.ref.change_energy(int(_parameters.assigned_time*_parameters.energy_change))
	save_parameters()
