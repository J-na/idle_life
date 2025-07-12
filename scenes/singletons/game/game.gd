class_name Game
extends Node
## the root node of the game

static var ref: Game ##Singleton reference

func _init() -> void: ##Constructor
	if not ref: ref = self 
	else: queue_free()

const PATH: String = "res://save.tres"
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
	Game.ref.data = Data.new()
	save_data()
