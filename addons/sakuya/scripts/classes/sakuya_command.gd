@icon("res://addons/sakuya/scripts/classes/icons/sakuya_command.png")
extends Resource
class_name SakuyaCommand

@export var alias : String = ""
@export_multiline var description = ""

## Array with command and all of its arguments. Index [0] is the command alias, index [1] is the first argument ect.
var context : PackedStringArray

## Override this function with your command logic
func execute() -> void:
	pass

## Helper function for checking if the command has a required number of arguments
func check_arg_count(required_argument_count : int) -> bool:
	return context.size() - 1 == required_argument_count

## Print an error message to the Output
func command_error(error_message : String) -> void:
	SakuyaRoot.out("[color=red]Error executing %s: %s[/color]" % [context[0], error_message])
	return
	
