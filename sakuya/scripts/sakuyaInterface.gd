extends Node

# MEMBERS #
@export var input : LineEdit
@export var output : RichTextLabel

func _ready() -> void:
	input.text_submitted.connect(SakuyaCLI.parse_command)
	input.text_submitted.connect(on_line_submitted)


func on_line_submitted(message : String) -> void:
	input.clear()
