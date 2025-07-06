class_name DataResources
extends Resource
## Contains data relative to in-game resources

@export var cash: int = 0 ## amount of cash owned by the player
@export var stress: int = 0 ##how stressed the player is
@export var max_stress: int = 100## Maximum stress cap you can deal with
@export var health: int = 100 ##current hit point
@export var max_health: int = 100 ## current max health
@export var energy: int = 100
@export var max_energy: int = 100

@export var cash_generation: int = 0
@export var health_generation: int = 0
@export var stress_generation: int = 0
@export var energy_generation: int = 0

@export var days_passed: int = 0
@export var available_hours: int = 24
