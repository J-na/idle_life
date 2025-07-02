class_name TimeManager
extends Node

static var ref: TimeManager ##Singleton reference

const utils = preload("res://scenes/singletons/utils/utils.gd")
var data: Data = Game.ref.data

func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

signal time_updated

func assign_time(activity: Activity) -> void:
	var error: Error = activity.assign_time()
	if error == OK: time_updated.emit()
	
func unassign_time(activity: Activity) -> void:
	var error: Error = activity.unassign_time()
	if error == OK: time_updated.emit()
