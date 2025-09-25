extends Window

#Required to keep compatibility with SakuyaTerminal
@export var IO : Node

@onready var current_position : Vector2 = Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height")) / 2.0 + Vector2(4, 24) - Vector2(self.get_size() / 2)

func _ready() -> void:
	self.set_position(current_position)
	self.visibility_changed.connect(func ():
		if self.is_visible() == true:
			self.set_position(current_position)
		else:
			current_position = self.get_position())
