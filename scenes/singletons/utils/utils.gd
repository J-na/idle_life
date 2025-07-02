class_name Utils
extends Resource

static func error_aware_connector(action: Signal, script: Callable) -> void:
	var error: Error = (action.connect(script) as Error)
	if error != OK: 
		print_debug("Error connecting %s to %s" %action.get_name() %script.get_method())
