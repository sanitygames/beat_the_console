extends Node

var now_stage = 0

var scenes = [
	"res://title/title.tscn",
	# "res://stage/stage1.tscn",
	"res://stage/stage2.tscn",
	"res://stage/stage3.tscn",
]
func _input(event):
	if event.is_action_pressed("retry"):
		var _e = get_tree().reload_current_scene()


