class_name ChoiceScreen
extends MarginContainer

const _choice_card_component: PackedScene = preload("res://scenes/components/choice_screen/choice_card/choice_card.tscn")
const _choice_screen_component: PackedScene = preload("res://scenes/components/choice_screen/choice_screen.tscn")
const utils = preload("res://scenes/singletons/utils/utils.gd")

var _choices: Array[ChoiceParameters] 

func _instantiate_choice_card(parameters: ChoiceParameters) -> void:
	var component: ChoiceCard = _choice_card_component.instantiate()
	component.set_parameters(parameters)
	(%ChoicesHolder as HBoxContainer).add_child(component)
	
func _ready() -> void:
	for choice: ChoiceParameters in _choices:
		_instantiate_choice_card(choice)
		
static func create_new_choice_screen(choices: Array[ChoiceParameters]) -> ChoiceScreen:
	Clock.ref.pause()
	var new_choice_screen: ChoiceScreen = _choice_screen_component.instantiate()
	new_choice_screen._choices = choices
	return new_choice_screen
