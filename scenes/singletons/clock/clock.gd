class_name Clock
extends Node

##singleton pattern creation
static var ref: Clock
func _init() -> void:
	if not ref: ref = self
	else: queue_free()

## defining the signal and clock speed
signal tick
var _tick_duration: float = 1.0
var _tick_progression: float = 0.0

func _process(delta:float) -> void: ##main clock signalling process
	_tick_progression += delta
	if _tick_progression > _tick_duration:
		_tick_progression -= _tick_duration
		tick.emit()
