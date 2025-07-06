class_name TimeConsole
extends VBoxContainer

const utils = preload("res://scenes/singletons/utils/utils.gd")

func _ready() -> void:
	utils.error_aware_connector((%PauseButton as Button).pressed, Clock.ref.pause)
	utils.error_aware_connector((%PlayButton as Button).pressed, Clock.ref.play)
	utils.error_aware_connector((%TwoTimesSpeed as Button).pressed, Clock.ref.two_times)
	utils.error_aware_connector((%TimeMultiplierButton as Button).pressed, timemultiplierbutton)
	utils.error_aware_connector(Clock.ref.tick, _update_label.bind("days passed"))
	utils.error_aware_connector(ActivityManager.ref.time_updated, _update_label.bind("available hours"))
	_update_label("all")

func timemultiplierbutton() -> void:
	ActivityManager.ref.change_assign_amount()
	(%TimeMultiplierButton as Button).text = "Assign x%s" %ActivityManager.ref.assign_amount
	for activity: ActivitySlot in (%ActivityContainer as VBoxContainer).get_children():
		activity.update_button_labels()

func _update_label(which: String) -> void:
	if which == "days passed" or which == "all":
		(%DaysPassedLabel as Label).text = "Days passed: %s" %Game.ref.data.resources.days_passed
	if which == "available hours" or which == "all":
		(%AvailableHoursLabel as Label).text = "Available hours: %s" %Game.ref.data.resources.available_hours
