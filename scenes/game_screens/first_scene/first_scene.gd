class_name FirstScene
extends Control
## What the user first sees when opening the project

const utils = preload("res://scenes/singletons/utils/utils.gd")

# var _activities: Array[ActivitySlot] 

func _add_activity(parameters: ActivityParameters) -> void:
	var component: ActivitySlot = ActivitySlot.create_new_activity(parameters)
	(%ActivityContainer as VBoxContainer).add_child(component)
	
func _ready() -> void:
	var work_parameters: ActivityParameters = ActivityManager.ref.create_activity_parameters("Work",0,8,3,0,1,-3)
	_add_activity(work_parameters)
	var sleep_parameters: ActivityParameters = ActivityManager.ref.create_activity_parameters("Sleep",1,8,0,1,-1,3)
	_add_activity(sleep_parameters)
	
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)

func _clear_save() -> void:
	Game.ref.clear_data()
	(%TimeConsole as TimeConsole)._update_label("all")
	(%StatsConsole as StatsConsole)._update_label("all")
	for activity: ActivitySlot in (%ActivityContainer as VBoxContainer).get_children():
		activity._update_time_label()
