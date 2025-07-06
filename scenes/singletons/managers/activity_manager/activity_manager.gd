class_name ActivityManager
extends Node

static var ref: ActivityManager ##Singleton reference

const utils = preload("res://scenes/singletons/utils/utils.gd")
var assign_amount: int = Game.ref.data.activities.assign_amount

func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

signal time_updated

func change_assign_amount() -> void:
	if assign_amount == 4:
		assign_amount = 8
	elif assign_amount == 2:
		assign_amount = 4
	elif assign_amount == 1:
		assign_amount = 2
	else: 
		assign_amount = 1

func assign_time(activity: ActivitySlot) -> void:
	var error: Error = activity.assign_time(assign_amount)
	if error == OK: time_updated.emit()
	
func unassign_time(activity: ActivitySlot) -> void:
	var error: Error = activity.unassign_time(assign_amount)
	if error == OK: time_updated.emit()
