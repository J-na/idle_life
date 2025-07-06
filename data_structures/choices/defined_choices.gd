class_name DefinedChoiceParameters
extends Resource

static func create_choice_parameters_from_parameters(_choice_title: String, _effects_text: String, _flavor_text: String) -> ChoiceParameters:
	var choice: ChoiceParameters = ChoiceParameters.new()
	choice.choice_title = _choice_title
	choice.effects_text = _effects_text
	choice.flavor_text = _flavor_text
	return choice

static var test_choice_1 = create_choice_parameters_from_parameters("test 1","test 1","test 1" )
static var test_choice_2 = create_choice_parameters_from_parameters("test 2","test 2","test 2" )
