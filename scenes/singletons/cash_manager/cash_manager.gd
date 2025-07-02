class_name CashManager
extends Node

## Singleton pattern
static var ref: CashManager
func _init() -> void:
	if not ref: ref = self
	else: queue_free()
	
signal cash_updated
#signal cash_created
#signal cash_consumed

var data: Data = Game.ref.data

func get_cash() -> int:
	return data.resources.cash

func create_cash(quantity: int) -> void:
	if quantity <= 0: 
		print_debug("Attempted to create negative or zero cash")
		return 
	data.resources.cash += quantity
	cash_updated.emit()

func consume_cash(quantity: int) -> Error:
	if quantity < 0: return FAILED
	if quantity > data.resources.cash: return FAILED
	data.resources.cash -= quantity
	cash_updated.emit()
	return OK
