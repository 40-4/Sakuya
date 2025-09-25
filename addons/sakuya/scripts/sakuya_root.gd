@icon("res://addons/sakuya/scripts/classes/icons/sakuya_node.png")
extends Node

@export_category("Main Settings")
@export var send_input_feedback : bool = true
@export var show_time : bool = false
@export var send_prints : bool = true
@export var send_errors : bool = true
@export_enum("Overlay", "Source Window") var terminal_style : int = 0
@export var trigger_button : Key = Key.KEY_QUOTELEFT
@export var command_list : Array[SakuyaCommand] = []


var terminal : Node


func _ready() -> void:
	#Adding action Event
	if InputMap.has_action("sakuya_toggle") == false:
		InputMap.add_action("sakuya_toggle")
		var event := InputEventKey.new()
		event.set_keycode(trigger_button)
		InputMap.action_add_event("sakuya_toggle", event)
	
	#Registering a new Logger, if SakuyaRoot allows Errors and Print messages to show in the console
	if self.send_prints == true or self.send_errors == true:
		var logger = Logger.new()
		logger.set_script(preload("res://addons/sakuya/scenes/sakuya_logger.gd"))
		OS.add_logger(logger)
	
	#Adding proper terminal
	var instance : Node
	match terminal_style:
		0:
			instance = preload("res://addons/sakuya/scenes/terminals/SakuyaOverlay.tscn").instantiate()
		1:
			instance = preload("res://addons/sakuya/scenes/terminals/SakuyaWindow.tscn").instantiate()
			instance.close_requested.connect(func(): terminal.hide())
	
	#Adds the terminal to the scene and creates access to the node
	terminal = instance
	self.add_child(terminal)
	terminal.hide()


func _process(_delta: float) -> void:
	# Responsible for showing and hiding the terminal when specified button is pressed
	if Input.is_action_just_pressed("sakuya_toggle"):
		terminal.set_visible(!terminal.is_visible())
		if terminal.is_visible() == false:
			terminal.IO.input.clear()
		else:
			terminal.IO.input.grab_focus()


## Sends output to the terminal
func out(message : String) -> void:
	#Justifies the text if show_time is set to true
	if self.show_time == true:
		message = message.replace("\n", "\n\t\t\t")
	terminal.IO.send_text(message)


## Evaluate command
func command(message : String) -> void:
	var split : PackedStringArray = message.split(" ")
	for command in command_list:
		if split[0] == command.alias:
			command.context = split
			command._run()
			return
	self.out("[color=red]Missing command: %s[/color]" % split[0])
