class_name ActivitySlot
extends MarginContainer

var activity_id: int

const _activity_slot_component: PackedScene = preload("res://scenes/components/activity_slot/activity_slot.tscn")
const utils = preload("res://scenes/singletons/utils/utils.gd")

func _ready() -> void:
	utils.error_aware_connector((%AssignTimeButton as Button).pressed, ActivityManager.ref.assign_time.bind(activity_id))
	utils.error_aware_connector((%UnassignTimeButton as Button).pressed, ActivityManager.ref.unassign_time.bind(activity_id))
	utils.error_aware_connector(ActivityManager.ref.time_updated, _update_time_label)
	utils.error_aware_connector(ActivityManager.ref.time_updated, _update_property_label)
	_update_property_label()
	_update_time_label()

func _update_time_label() -> void:
	var activity_parameters: ActivityParameters = ActivityManager.ref.get_activity_by_id(activity_id)
	(%ActivityTimeLabel as Label).text = "%s: %s hours" %[activity_parameters.activity_name, activity_parameters.assigned_time]

func _update_property_label() -> void:
	var activity_parameters: ActivityParameters = ActivityManager.ref.get_activity_by_id(activity_id)
	if Game.ref.data.progression.activity_information_unlocked:
		(%ActivityPropertyLabel as Label).text = "Cash: %s, health: %s, stress: %s, energy: %s" %[activity_parameters.cash_change, activity_parameters.health_change, activity_parameters.stress_change, activity_parameters.energy_change]
	else:
		(%ActivityPropertyLabel as Label).text = ""

func update_button_labels() -> void:
	(%AssignTimeButton as Button).text = "+%s" %ActivityManager.ref.assign_amount
	(%UnassignTimeButton as Button).text = "-%s" %ActivityManager.ref.assign_amount
