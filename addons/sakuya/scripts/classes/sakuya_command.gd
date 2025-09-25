@icon("res://addons/sakuya/scripts/classes/icons/sakuya_command.png")
extends Resource
class_name SakuyaCommand
## Class representing the barebone command supported by Sakuya.


## The command alias is the keyword by which it's invoked by the Sakuya Terminal.
@export var alias : String = ""

## Argument count shows how many argument this command supports.
@export var argument_count : int = 1

## Description of a command.
@export_multiline var description = ""


## Array with command and all of its arguments. Index [0] is the command alias, index [1] is the first argument ect.
var context : PackedStringArray


## This is an internal function that does a basic argument count checking and calls the [method execute].
func _run():
	if check_arg_count() == true:
		self.execute()
		return
	else:
		self.command_error("Invalid argument count")
		return


## Override this function with your command logic.
func execute() -> void:
	pass


## Helper function for checking if the command has a required number of arguments. [br]
## If you want your command to support more than one argument number, you can override it. [br]
## You'll propably will have to add additional checks inside [method execute], but that depends on what you want to accomplish.
func check_arg_count() -> bool:
	return context.size() - 1 == argument_count


## Prints an error message to the Output.
func command_error(error_message : String) -> void:
	SakuyaRoot.out("[color=red]Error executing %s: %s[/color]" % [context[0], error_message])
	return
