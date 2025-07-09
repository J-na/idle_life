class_name DefinedChoiceParameters
extends Resource

static func create_choice_parameters_from_parameters(_choice_title: String, _effects_text: String, _flavor_text: String, _activity_unlocks: Array[ActivityParameters], _progress_tutorial: bool = false) -> ChoiceParameters:
	var choice: ChoiceParameters = ChoiceParameters.new()
	choice.choice_title = _choice_title
	choice.effects_text = _effects_text
	choice.flavor_text = _flavor_text
	choice.activity_unlocks = _activity_unlocks
	choice.progress_tutorial = _progress_tutorial
	return choice

static var test_choice_1: ChoiceParameters = create_choice_parameters_from_parameters("test 1","test 1","test 1", [] )
static var test_choice_2: ChoiceParameters = create_choice_parameters_from_parameters("test 2","test 2","test 2", [] )
static var baby_cry_1: ChoiceParameters = create_choice_parameters_from_parameters("Cry", "You don't know what this is, but it just feels right.","waah!", [DefinedActivityParameters.tutorial_cry],true)
static var baby_cry_2: ChoiceParameters = create_choice_parameters_from_parameters("Cry", "What else could your mouth be for?","I must scream.", [DefinedActivityParameters.tutorial_cry],true)
