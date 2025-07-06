class_name BabyScene
extends Control

## What the user first sees when opening the project

const utils = preload("res://scenes/singletons/utils/utils.gd")

const _activity_slot_component: PackedScene = preload("res://scenes/components/activity_slot/activity_slot.tscn")
# var _activities: Array[ActivitySlot] 

func _instantiate_activity(parameters: ActivityParameters) -> void:
	var component: ActivitySlot = _activity_slot_component.instantiate()
	component.set_parameters(parameters)
	(%ActivityContainer as VBoxContainer).add_child(component)
	
func _ready() -> void:
	var cry_parameters: ActivityParameters = ActivityManager.ref.create_activity_parameters("Cry",0,8,3,0,1,-3)
	_instantiate_activity(cry_parameters)
	var sleep_parameters: ActivityParameters = ActivityManager.ref.create_activity_parameters("Sleep",1,20,0,1,-1,3)
	_instantiate_activity(sleep_parameters)
	var choice_1: ChoiceParameters = ChoiceParameters.new()
	var choice_2: ChoiceParameters = ChoiceParameters.new()
	var choices: Array[ChoiceParameters] = [choice_1,choice_2]
	
	for i: int in range(choices.size()):
		var choice: ChoiceParameters = choices[i]
		choice.choice_title = "Title %s" %i
		choice.effects_text = "Effect %s" %i
		choice.flavor_text = "Flavour %s" %i
	
	var new_choice_screen: ChoiceScreen = ChoiceScreen.create_new_choice_screen(choices)
	add_child(new_choice_screen)


	
