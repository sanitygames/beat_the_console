extends Node


export (PackedScene) var player_death_particle

var now_stage = 0


var scenes = [
	"res://stage/ver1_2_1/stage0.tscn",
	"res://stage/ver1_2_1/stage1.tscn",
	"res://stage/ver1_2_1/stage2.tscn",
	"res://stage/ver1_2_1/stage3.tscn",
	"res://stage/ver1_2_1/stage4.tscn",
	"res://stage/ver1_2_1/stage5.tscn",
	"res://stage/ver1_2_1/stage6.tscn",
	"res://stage/ver1_2_1/stage7.tscn",
	"res://stage/ver1_2_1/stage8.tscn",
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
	$Transition/Label.text = "STAGE %02d / %02d" % [now_stage, scenes.size() -1]
	$Transition/Label.visible = true
	yield(get_tree().create_timer(1.0),"timeout")
	$Transition/Label.visible = false
	$Transition/AnimationPlayer.play("open")
	var _e = get_tree().change_scene(scenes[now_stage])
	yield($Transition/AnimationPlayer, "animation_finished")

func get_destroy_effect():
	var _p = player_death_particle.instance()
	return _p
