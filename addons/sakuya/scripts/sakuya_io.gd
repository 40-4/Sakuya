extends Node
## This node is responsible for getting the input command and for sending an output.

@export var input : LineEdit
@export var output : RichTextLabel

func _ready() -> void:
	input.text_submitted.connect(_text_received)

func _text_received(command : String) -> void:
	if command != "":
		input.clear()
		if SakuyaRoot.send_input_feedback == true:
			send_text(command, true)
		
		SakuyaRoot.command(command)

func send_text(message : String, is_feedback : bool = false) -> void:
	if SakuyaRoot.show_time == true and is_feedback == false:
		var time = Time.get_time_dict_from_system()
		message = "[color=gray]%02d:%02d:%02d[/color]\t%s" % [time.hour, time.minute, time.second, message]
	
	if is_feedback:
		message = "[color=gray]> [/color]" + message
	
	message += "\n"
	output.append_text(message)
