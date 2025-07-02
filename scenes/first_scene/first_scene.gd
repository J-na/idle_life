class_name FirstScene
extends Control
## What the user first sees when opening the project

const utils = preload("res://scenes/singletons/utils/utils.gd")

@onready
var moneylabel: Label = get_node("MarginContainer/MoneyLabel")
var cashmanager: CashManager = CashManager.ref

func _ready() -> void:
	utils.error_aware_connector(cashmanager.cash_updated, _update_label)
	utils.error_aware_connector((get_node("MarginContainer/WorkButton") as Button).pressed, _on_button_pressed)
	utils.error_aware_connector((%SaveClearButton as Button).pressed, _clear_save)
	_update_label()

func _update_label() -> void: ## updates the label to display the current amount of idleons
	moneylabel.text = "Money: $%s" %cashmanager.get_cash()
	
func _on_button_pressed() -> void: ## triggered when button is pressed
	cashmanager.create_cash(5)

func _clear_save() -> void:
	Game.ref.clear_data()
	_update_label()
	
