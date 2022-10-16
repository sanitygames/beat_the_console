extends CanvasLayer


func transition_start(value = 0):
	$AnimationPlayer.play("close")
	yield($AnimationPlayer, "animation_finished")
	Global.now_stage = (Global.now_stage + 1) % Global.scenes.size()
	$Label.text = "STAGE %02d / 10" % Global.now_stage
	$Label.visible = true
	yield(get_tree().create_timer(1.0),"timeout")
	$Label.visible = false
	$AnimationPlayer.play("open")
	get_tree().change_scene(Global.scenes[Global.now_stage])
	yield($AnimationPlayer, "animation_finished")
