@tool
extends EditorPlugin


func _enable_plugin() -> void:
	add_autoload_singleton("SakuyaRoot", "res://addons/sakuya/scenes/SakuyaRoot.tscn")

func _disable_plugin() -> void:
	remove_autoload_singleton("SakuyaRoot")
