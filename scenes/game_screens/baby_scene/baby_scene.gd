class_name BabyScene
extends Control

## What the user first sees when opening the project

const base_screen: PackedScene = preload("res://scenes/game_screens/base_scene/base_scene.tscn")

func _ready() -> void:
	var main_screen: BaseScene = base_screen.instantiate()
	add_child(main_screen)

	main_screen.add_activity(DefinedActivityParameters.cry)
	main_screen.add_activity(DefinedActivityParameters.baby_sleep)

	var choices: Array[ChoiceParameters] = [DefinedChoiceParameters.test_choice_1,DefinedChoiceParameters.test_choice_2]
	main_screen.add_choice(choices)


	
