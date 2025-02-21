@icon("res://addons/sakuya/icons/sakuya_command.png")
extends Resource
class_name SakuyaCommand

# VARIABLES #
@export var alias : String
@export_multiline var description : String

## Command Logic needs to be implemented here, overwriting this function. [br]
## [code]command[/code] is an array consisting of all arguments, including command's alias. [br]
func execute(command : PackedStringArray) -> void:
	pass
