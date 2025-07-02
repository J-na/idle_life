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

func change_cash(quantity: int) -> Error:
	if  data.resources.cash + quantity < 0: 
		print("Not enough money")
		return FAILED
	data.resources.cash += quantity
	cash_updated.emit()
	return OK
