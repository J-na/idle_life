class_name CashGenerator
extends Node

const utils = preload("res://scenes/singletons/utils/utils.gd")

## Singleton pattern
static var ref: CashGenerator
func _init() -> void:
	if not ref: ref = self
	else: queue_free()

var _cycle_duration: float = 1.0
var _cycle_progression: float = 0.0
var _production_amount: int = 5

func _ready() -> void:
	utils.error_aware_connector(Clock.ref.tick, _progress_cycle)
	
func _progress_cycle() -> void:
	if not Game.ref.data.progression.generator_unlocked: return
	_cycle_progression += 1.0
	if _cycle_progression >= _cycle_duration:
		_cycle_progression -= _cycle_duration
		CashManager.ref.create_cash(_production_amount)
