extends Node

export (PackedScene) var player_death_particle

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

	if event.is_action_pressed("next"):
		transition_start()


func transition_start():
	$Transition/AnimationPlayer.play("close")
	yield($Transition/AnimationPlayer, "animation_finished")
	now_stage = (now_stage + 1) % scenes.size()
	$Transition/Label.text = "STAGE %02d / 10" % now_stage
	$Transition/Label.visible = true
	yield(get_tree().create_timer(1.0),"timeout")
	$Transition/Label.visible = false
	$Transition/AnimationPlayer.play("open")
	var _e = get_tree().change_scene(scenes[now_stage])
	yield($Transition/AnimationPlayer, "animation_finished")

func get_destroy_effect():
	var _p = player_death_particle.instance()
	return _p
