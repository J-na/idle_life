extends Control

## What the user first sees when opening the project

const base_screen: PackedScene = preload("res://scenes/game_screens/base_scene/base_scene.tscn")
const base_tutorial_text_component: PackedScene = preload("res://scenes/components/tutorial_text/tutorial_text_component.tscn")

const utils = preload("res://scenes/singletons/utils/utils.gd")
var current_choice_screen: ChoiceScreen
var data: Data = Game.ref.data

func _ready() -> void:
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)
	(%TimeConsole as CanvasItem).hide()
	(%CryActivityContainer as CanvasItem).hide()
	
	utils.error_aware_connector((%CryAssignTimeButton as Button).pressed, ActivityManager.ref.assign_time.bind(0))
	utils.error_aware_connector((%CryUnassignTimeButton as Button).pressed, ActivityManager.ref.unassign_time.bind(0))
	utils.error_aware_connector(ActivityManager.ref.time_updated, _update_time_labels)
	progress_tutorial()
	
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
		remove_child(current_choice_screen)
		current_choice_screen = null
	for effect: Callable in _parameters.unique_effects:
		effect.call()
	if _parameters.progress_tutorial:
		progress_tutorial()

func progress_tutorial() -> void:
	var _tutorial_text_component: Control = base_tutorial_text_component.instantiate()
	Game.ref.data.progression.tutorial_progress += 1
	if data.progression.tutorial_progress == 1:
		var baby_cry_1: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Cry", "You don't know what this is, but it just feels right.","waah!", ["tutorial cry"],[],true)
		var baby_cry_2: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Cry", "What else could your mouth be for?","I must scream.", ["tutorial cry"],[],true)
		var choices: Array[ChoiceParameters] = [baby_cry_1,baby_cry_2]
		add_choice(choices, "", "You are cruelly squeezed, jostled, and prodded for what seems like an eternity, until... Bright light overwhelms your retina even through your closed eyes! Your sticky skin shivers at the dry, cold, air. All the muffled sounds that used to comfort you are now seem louder and sharp to your ears! You do not understand what happened, but you don't like it. \n \n What do you do? \n \n")
	if data.progression.tutorial_progress == 2:
		(%CryActivityContainer as CanvasItem).show()
		(%TutorialProgress1 as CanvasItem).show()
		await ActivityManager.ref.time_updated
		print_debug("await checked")
		(%TutorialProgress1 as CanvasItem).hide()
		(%TutorialProgress2 as CanvasItem).show()
		await get_tree().create_timer(3.0).timeout
		(%TutorialProgress2 as CanvasItem).hide()
		ActivityManager.ref.set_activity_parameters_by_name("tutorial cry", {"max_time":8})
		var crybaby: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Cry more", "This seemed to help before, surely it will work again...","Fortune favors the bold", [],[],true)
		var chillbaby: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Remain calm", "There is no need to behave irrationally. Surely this comforting presence will take care of my needs","Good things come to those who wait", [],[set_tutorial_progress.bind(3)],true)
		var choices: Array[ChoiceParameters] = [crybaby,chillbaby]
		add_choice(choices, "", "Success! You feel a comfortable warmth as you are held by soft arms. The smell feels right, and you hear a soothing voice, vaguely familiar yet distorted by the strange new substance you find yourself breathing in. \n\n However, all is not well. Your entire being is consumed by ravenous hunger radiating out from your belly. \n \n What do you do? \n \n")
	if data.progression.tutorial_progress  == 3:
		(%TutorialProgress3 as CanvasItem).show()
		Game.ref.data.progression.tutorial_progress += 1
	if data.progression.tutorial_progress  == 4:
		ActivityManager.ref.unassign_time(0)
		(%TutorialProgress4 as CanvasItem).show()

		
	if data.progression.tutorial_progress == 5:
		var baby_suck: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Suck", "There is this primal urge","waah!", ["tutorial cry"],[],true)
		var baby_reject: ChoiceParameters = ChoiceParameters.create_choice_parameters_from_parameters("Suck", "There is this primal urge","waah!", ["tutorial cry"],[],true)
		var choices: Array[ChoiceParameters] = [baby_suck,baby_reject]
		add_choice(choices, "", "You are cruelly squeezed, jostled, and prodded for what seems like an eternity, until... Bright light overwhelms your retina even through your closed eyes! Your sticky skin shivers at the dry, cold, air. All the muffled sounds that used to comfort you are now seem louder and sharp to your ears! You do not understand what happened, but you don't like it. \n \n What do you do? \n \n")

func set_tutorial_progress(stage: int) -> void:
	data.progression.tutorial_progress = stage

func _update_time_labels() -> void:
	(%CryTimeLabel as Label).text = "Cry: %s hours " %ActivityManager.ref.get_activity_by_name("tutorial cry").assigned_time

func update_button_labels() -> void:
	(%AssignTimeButton as Button).text = "+%s" %ActivityManager.ref.assign_amount
	(%UnassignTimeButton as Button).text = "-%s" %ActivityManager.ref.assign_amount

func _clear_save() -> void:
	Game.ref.clear_data()
	(%TimeConsole as TimeConsole)._update_label("all")
	_update_time_labels()
