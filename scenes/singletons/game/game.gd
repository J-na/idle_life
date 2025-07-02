class_name Game
extends Node
## the root node of the game

static var ref: Game ##Singleton reference

func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

const PATH: String = "C://Users//jonat//OneDrive//Documenten//Gamedev stuff//idle_life//save.tres"
var data: Data = load_data() ##main data object of the game

func load_data() -> Data:
	if ResourceLoader.exists(PATH): return load(PATH)
	else: return Data.new()

func save_data() -> void:
	var error: Error = ResourceSaver.save(data,PATH)
	if error != OK: print_debug("error saving game?")
	
func _exit_tree() -> void:
	save_data()

func clear_data() -> void:
	data.resources.cash = 0 ## amount of cash owned by the player
	data.resources.stress = 0
	data.resources.health = 100
	data.progression.generator_unlocked = false
	
		
