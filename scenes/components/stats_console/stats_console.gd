class_name StatsConsole
extends VBoxContainer

const utils = preload("res://scenes/singletons/utils/utils.gd")

func _ready() -> void:
	utils.error_aware_connector(CashManager.ref.cash_updated, _update_label.bind("money"))
	utils.error_aware_connector(HealthManager.ref.health_updated, _update_label.bind("health"))
	utils.error_aware_connector(StressManager.ref.stress_updated, _update_label.bind("stress"))
	utils.error_aware_connector(EnergyManager.ref.energy_updated, _update_label.bind("energy"))
	_update_label("all")
	
func _update_label(type: String) -> void: ## updates the label to display the current amount of idleons
	if type == "money" or type == "all":
		(%MoneyLabel as Label).text = "Money: $%s" %CashManager.ref.get_cash()
	if type == "health" or type == "all":
		(%HealthLabel as Label).text = "%s/%s health" %HealthManager.ref.get_health()
		(%HealthBar as ProgressBar).max_value  = HealthManager.ref.get_health()[1]
		(%HealthBar as ProgressBar).value  = HealthManager.ref.get_health()[0]
	if type == "stress" or type == "all":
		(%StressLabel as Label).text = "%s/%s stress" %StressManager.ref.get_stress()
		(%StressBar as ProgressBar).max_value = StressManager.ref.get_stress()[1]
		(%StressBar as ProgressBar).value = StressManager.ref.get_stress()[0]
	if type == "energy" or type == "all":
		(%EnergyLabel as Label).text = "%s/%s energy" %EnergyManager.ref.get_energy()
		(%EnergyBar as ProgressBar).max_value = EnergyManager.ref.get_energy()[1]
		(%EnergyBar as ProgressBar).value = EnergyManager.ref.get_energy()[0]
