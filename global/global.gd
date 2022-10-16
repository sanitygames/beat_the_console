extends Node

func _input(event):
	if event.is_action_pressed("retry"):
		var _e = get_tree().reload_current_scene()


