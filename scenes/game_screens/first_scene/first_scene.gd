class_name FirstScene
extends BaseScene
## What the user first sees when opening the project

const base_screen: PackedScene = preload("res://scenes/game_screens/base_scene/base_scene.tscn")

func _ready() -> void:
	var main_screen: BaseScene = base_screen.instantiate()
	add_child(main_screen)
	main_screen.add_activity("work")
	main_screen.add_activity("sleep")
	
	var test_choice_1: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("test 1","test 1","test 1", [],[],false )
	var test_choice_2: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("test 2","test 2","test 2", [],[],false )

	var choices: Array[ChoiceParameters] = [test_choice_1,test_choice_2]
	main_screen.add_choice(choices)
