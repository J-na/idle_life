class_name FirstScene
extends Control
## What the user first sees when opening the project

const utils = preload("res://scenes/singletons/utils/utils.gd")

#var _activities: Array[Activity] = []

@onready
var work: Activity = Activity.new(0,10,0,-1,-3)

func _ready() -> void:
	utils.error_aware_connector(CashManager.ref.cash_updated, _update_label.bind("money"))
	utils.error_aware_connector(HealthManager.ref.health_updated, _update_label.bind("health"))
	utils.error_aware_connector(StressManager.ref.stress_updated, _update_label.bind("stress"))
	utils.error_aware_connector(EnergyManager.ref.energy_updated, _update_label.bind("energy"))
	utils.error_aware_connector(TimeManager.ref.time_updated, _update_label.bind("time_management"))
	utils.error_aware_connector(Clock.ref.tick, _update_label.bind("time"))
	utils.error_aware_connector((%AssignWork as Button).pressed, TimeManager.ref.assign_time.bind(work))
	utils.error_aware_connector((%UnassignWork as Button).pressed, TimeManager.ref.unassign_time.bind(work))
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)
	utils.error_aware_connector((%PauseButton as Button).pressed, Clock.ref.pause)
	utils.error_aware_connector((%PlayButton as Button).pressed, Clock.ref.play)
	utils.error_aware_connector((%TwoTimesSpeed as Button).pressed, Clock.ref.two_times)
	_update_label("all")

func _update_label(type: String) -> void: ## updates the label to display the current amount of idleons
	if type == "money" or type == "all":
		(%MoneyLabel as Label).text = "Money: $%s" %CashManager.ref.get_cash()
	if type == "health" or type == "all":
		(%HealthLabel as Label).text = "%s/%s HP" %HealthManager.ref.get_hp()
		(%HealthBar as ProgressBar).max_value  = HealthManager.ref.get_hp()[1]
		(%HealthBar as ProgressBar).value  = HealthManager.ref.get_hp()[0]
	if type == "stress" or type == "all":
		(%StressLabel as Label).text = "%s/%s stress" %StressManager.ref.get_stress()
		(%StressBar as ProgressBar).max_value = StressManager.ref.get_stress()[1]
		(%StressBar as ProgressBar).value = StressManager.ref.get_stress()[0]
	if type == "energy" or type == "all":
		(%EnergyLabel as Label).text = "%s/%s energy" %EnergyManager.ref.get_energy()
		(%EnergyBar as ProgressBar).max_value = EnergyManager.ref.get_energy()[1]
		(%EnergyBar as ProgressBar).value = EnergyManager.ref.get_energy()[0]
	if type == "time_management" or type == "all":
		(%AvailableHoursLabel as Label).text = "Available hours: %s" %Game.ref.data.resources.available_hours
		(%WorkTimeLabel as Label).text = "Assigned hours %s" %Game.ref.data.activities.activity_states[0].assigned_time
	if type == "time" or type == "all":
		(%DaysPassedLabel as Label).text = "Days passed: %s" %Game.ref.data.resources.days_passed
		
func _clear_save() -> void:
	Game.ref.clear_data()
	_update_label("all")
	
