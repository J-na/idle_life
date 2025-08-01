extends Control

## What the user first sees when opening the project

const base_screen: PackedScene = preload("res://scenes/game_screens/base_scene/base_scene.tscn")
const base_tutorial_text_component: PackedScene = preload("res://scenes/components/tutorial_text/tutorial_text_component.tscn")

const utils = preload("res://scenes/singletons/utils/utils.gd")
var current_choice_screen: ChoiceScreen

func add_activity(dict_id: String) -> void:
	var activity: ActivitySlot = ActivityManager.ref.create_new_activity_by_name(dict_id)
	(%ActivitiesContainer as VBoxContainer).add_child(activity)

func add_choice(choices: Array[ChoiceParameters], choice_title: String = "Make your choice:", choice_text: String = "") -> void:
	if current_choice_screen == null:
		current_choice_screen = ChoiceScreen.create_new_choice_screen(choices)
		(current_choice_screen.get_node("%ChoiceTitle") as Label).text = choice_title
		(current_choice_screen.get_node("%ChoiceText") as Label).text = choice_text
		add_child(current_choice_screen)
		for choice: ChoiceCard in current_choice_screen.get_node("%ChoicesHolder").get_children():
			utils.error_aware_connector(choice.choice_made, execute_choice)
	
func execute_choice(_parameters: ChoiceParameters) -> void:
	if current_choice_screen != null:
		for activity: String in _parameters.activity_unlocks:
			add_activity(activity)
		remove_child(current_choice_screen)

func _ready() -> void:
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)

func _clear_save() -> void:
	Game.ref.clear_data()
	(%TimeConsole as TimeConsole)._update_label("all")
	(%StatsConsole as StatsConsole)._update_label("all")
	for activity: ActivitySlot in (%ActivitiesContainer as VBoxContainer).get_children():
		activity._update_time_label()
