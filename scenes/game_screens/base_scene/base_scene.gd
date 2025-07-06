class_name BaseScene
extends Control

const utils = preload("res://scenes/singletons/utils/utils.gd")

func add_activity(parameters: ActivityParameters) -> void:
	var activity: ActivitySlot = ActivitySlot.create_new_activity(parameters)
	(%ActivityContainer as VBoxContainer).add_child(activity)

func add_choice(choices: Array[ChoiceParameters]) -> void:
	var new_choice_screen: ChoiceScreen = ChoiceScreen.create_new_choice_screen(choices)
	add_child(new_choice_screen)

func _ready() -> void:
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)

func _clear_save() -> void:
	Game.ref.clear_data()
	(%TimeConsole as TimeConsole)._update_label("all")
	(%StatsConsole as StatsConsole)._update_label("all")
	for activity: ActivitySlot in (%ActivityContainer as VBoxContainer).get_children():
		activity._update_time_label()
