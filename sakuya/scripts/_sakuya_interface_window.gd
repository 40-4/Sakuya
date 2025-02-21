extends Window

# VARIABLES #
@export var interface : Node

var _position : Vector2i
var _been_activated : bool = false

# FUNCTIONS #
func _enter_tree() -> void:
	self.set_size(get_tree().get_root().get_size() / 2)


func _on_visibility_changed() -> void:
	if self.visible == false:
		_position = self.get_position()
	elif _been_activated == true:
		self.set_position(_position)
	else:
		_been_activated = true
