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
		logger.set_script(preload("res://addons/sakuya/scenes/SakuyaLogger.gd"))
		OS.add_logger(logger)
	
	#Adding proper terminal
	var i : Node
	match terminal_style:
		0:
			i = preload("res://addons/sakuya/scenes/terminals/SakuyaOverlay.tscn").instantiate()
			self.add_child(i)
		1:
			i = preload("res://addons/sakuya/scenes/terminals/SakuyaWindow.tscn").instantiate()
			i.close_requested.connect(func(): terminal.set_visible(false))
			self.add_child(i)
	
	#Creates and access to the terminal
	terminal = self.get_child(0)
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
	if self.show_time == true:
		message = message.replace("\n", "\n\t\t\t")
	terminal.IO.send_text(message)

## Evaluate command
func command(message : String) -> void:
	var split : PackedStringArray = message.split(" ")
	for command in command_list:
		if split[0] == command.alias:
			command.context = split
			command.execute()
			return
		self.out("[color=red]Missing command: %s[/color]" % split[0])
