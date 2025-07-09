class_name Data
extends Resource
## main data object used to save and load

@export var resources: DataResources = DataResources.new() ##contains data of in-game resources
@export var progression: DataProgression = DataProgression.new() ## contains data about progression statistics
@export var activities: DataActivities = DataActivities.new()
@export var stats: DataStats = DataStats.new()
