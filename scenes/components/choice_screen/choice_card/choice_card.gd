class_name ChoiceCard
extends MarginContainer

var _parameters: ChoiceParameters
const utils = preload("res://scenes/singletons/utils/utils.gd")

func _ready() -> void:
	utils.error_aware_connector((%ChoiceButton as Button).pressed, choose_option)
	(%TitleLabel as Label).text = "%s" %_parameters.choice_title
	(%EffectsLabel as Label).text = "%s" %_parameters.effects_text
	(%FlavorTextLabel as Label).text = "%s" %_parameters.flavor_text

func set_parameters(parameters: ChoiceParameters) -> void:
	_parameters = parameters

func choose_option() -> void:
	#Apply_parameters
	var choice_screen: ChoiceScreen = get_parent()
	choice_screen.queue_free()
