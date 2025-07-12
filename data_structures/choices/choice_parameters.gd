class_name ChoiceParameters
extends Resource

@export var choice_title: String
@export var effects_text: String
@export var flavor_text: String

@export var activity_unlocks: Array[String]
@export var unique_effects: Array[Callable]

@export var progress_tutorial: bool = false

static func create_choice_parameters_from_parameters(_choice_title: String, _effects_text: String, _flavor_text: String, _activity_unlocks: Array[String], _unique_effects: Array[Callable], _progress_tutorial: bool = false) -> ChoiceParameters:
	var choice: ChoiceParameters = ChoiceParameters.new()
	choice.choice_title = _choice_title
	choice.effects_text = _effects_text
	choice.flavor_text = _flavor_text
	choice.activity_unlocks = _activity_unlocks
	choice.unique_effects = _unique_effects
	choice.progress_tutorial = _progress_tutorial
	return choice
