@icon("res://addons/sakuya/icons/sakuya_cli.png")
extends Node

# SETTINGS #
@export_category("Sakuya Settings")

@export_enum("Overlay", "Window", "Floating") var display_mode : int = 0

@export var override_toggle_action : String = ""

@export_enum("None", "Default", "Time Signed") var logging_mode : int = 1


# THEME OVERRIDES #
@export_category("Visual Overrides")

@export var theme_override : Theme


# CLI SETTINGS #
@export_category("Sakuya Commands")

@export var loaded_commands : Array[SakuyaCommand]

# VARIABLES #
enum MessageType {INFO, WARN, ERROR}
var _visible : bool = false
var _child_interface : Node = null
var _was_pressed : bool = false

var alias_dict : Dictionary

# PRIVATE METHODS #
#region
func _enter_tree() -> void:
	match display_mode:
		0:
			_child_interface = preload("res://addons/sakuya/scenes/_sakuya_interface_overlay.tscn").instantiate()
		1:
			_child_interface = preload("res://addons/sakuya/scenes/_sakuya_interface_window.tscn").instantiate()
			_child_interface.set_flag(Window.FLAG_POPUP, true)
			_child_interface.close_requested.connect(self._set_visible.bind(false))
		2:
			_child_interface = preload("res://addons/sakuya/scenes/_sakuya_interface_window.tscn").instantiate()
			_child_interface.set_force_native(true)
			_child_interface.close_requested.connect(self._set_visible.bind(false))
	
	
	# Adding Interface
	self.add_child(_child_interface)
	
	if theme_override != null:
		self.propagate_call("set_theme", [theme_override])
	
	# Prepare alias dictionary
	for command in loaded_commands:
		alias_dict[command.alias] = command


func _set_visible(state : bool) -> void:
	_visible = state
	_child_interface.set_visible(state)
	if state == false:
		_child_interface.propagate_call("release_focus")


func _process(_delta: float) -> void:
	if override_toggle_action != "":
		if Input.is_action_just_pressed(override_toggle_action):
			_set_visible(!_visible)
	elif Input.is_physical_key_pressed(KEY_QUOTELEFT) and _was_pressed == false:
		_set_visible(!_visible)
		_was_pressed = true
	elif !Input.is_physical_key_pressed(KEY_QUOTELEFT):
		_was_pressed = false

func parse_command(message : String) -> void:
	var command : PackedStringArray = message.split(" ")
	if alias_dict.has(command[0]):
		alias_dict[command[0]].execute(command)
	else:
		log_message("Command \"%s\" not found!" % command[0], MessageType.ERROR)

#endregion

# PUBLIC METHODS #

func log_message(message : String, type : MessageType = MessageType.INFO) -> void:
	var time : String = Time.get_time_string_from_system(false)
	var prefix : String = "INFO"
	
	match type:
		MessageType.WARN:
			prefix = "[color=gold]WARN[/color]"
			message = "[color=gold]" + message + "[/color]"
		MessageType.ERROR:
			prefix = "[color=red]ERROR[/color]"
			message = "[color=red]" + message + "[/color]"
	
	match logging_mode:
		1:
			_child_interface.interface.output.append_text("\n%s" % message)
		2:
			_child_interface.interface.output.append_text("\n[color=dim_gray]%s:[/color] %s" % [time,message])
	
	print_rich("%s> [color=dim_gray]%s:[/color] %s" % [prefix, time, message])
