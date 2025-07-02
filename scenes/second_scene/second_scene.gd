class_name SecondScene
extends Control

const utils = preload("res://scenes/singletons/utils/utils.gd")
const COST: int = 25

func _ready() -> void:
	if Game.ref.data.progression.generator_unlocked:
		_display_view(true)
	else:
		_display_view(false)
		utils.error_aware_connector((get_node("TabContainer/Locked/UnlockButton") as Button).pressed, _on_unlock_button_pressed)

func _display_view(unlocked: bool = false) -> void:
	($TabContainer as TabContainer).current_tab = int(unlocked)
	
func _on_unlock_button_pressed() -> void:
	var error: Error = CashManager.ref.consume_cash(COST)
	if error: return
	Game.ref.data.progression.generator_unlocked = true
	_display_view(true)
