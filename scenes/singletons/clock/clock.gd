class_name Clock
extends Node

##singleton pattern creation
static var ref: Clock
func _init() -> void:
	if not ref: ref = self
	else: queue_free()

## defining the signal and clock speed
signal tick
var _tick_duration: float = 2.0
var _tick_progression: float = 0.0
var paused: bool = false
var two_times_speed: bool = false

func pause() -> void:
	paused = true
	
func play() -> void:
	paused = false
	two_times_speed = false

func two_times() -> void:
	paused = false
	two_times_speed = true

func _process(delta:float) -> void: ##main clock signalling process
	var mult: int = 1
	if two_times_speed:
		mult = 2
	if not paused:
		_tick_progression += mult*delta
		if _tick_progression > _tick_duration:
			_tick_progression -= _tick_duration
			Game.ref.data.resources.days_passed += 1
			tick.emit()
