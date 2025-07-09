class_name BabyScene
extends BaseScene

## What the user first sees when opening the project

const base_screen: PackedScene = preload("res://scenes/game_screens/base_scene/base_scene.tscn")
const tutorial_text_component: PackedScene = preload("res://scenes/components/tutorial_text/tutorial_text_component.tscn")
var main_screen: BaseScene = base_screen.instantiate()

func _ready() -> void:
	add_child(main_screen)
	(main_screen.get_node("%StatsConsole") as CanvasItem).hide()
	(main_screen.get_node("%TimeConsole") as CanvasItem).hide()

	var choices: Array[ChoiceParameters] = [DefinedChoiceParameters.baby_cry_1,DefinedChoiceParameters.baby_cry_2]
	main_screen.add_choice(choices, "", "You are cruelly squeezed, jostled, and prodded for what seems like an eternity, until... Bright light overwhelms your retina even through your closed eyes! Your sticky skin shivers at the dry, cold, air. All the muffled sounds that used to comfort you are now seem louder and sharp to your ears! You do not understand what happened, but you don't like it. \n \n What do you do? \n \n")
	for choice: ChoiceCard in main_screen.get_node("ChoiceScreen/%ChoicesHolder").get_children():
		utils.error_aware_connector(choice.choice_made, progress_tutorial)

func progress_tutorial(parameters:ChoiceParameters) -> void:
	var tutorial_progress: int = Game.ref.data.progression.tutorial_progress
	var tutorial_text_component: Control = tutorial_text_component.instantiate()
	if tutorial_progress == 0:
		tutorial_text_component.get_node("%TutorialTextLabel").text = "Welcome to idle life. \n Click the +1 button to assign time to an activity. Try it out with the 'cry' activity now!"
		main_screen.add_child(tutorial_text_component)
		utils.error_aware_connector(main_screen.get_node("%ActivityContainer").get_child(0).get_node("%AssignTimeButton").pressed, progress_tutorial)
		Game.ref.data.progression.tutorial_progress += 1
	if tutorial_progress == 1:
		print("tutorial progressed")
	
		
