extends Node2D

func _ready():
	Transition.get_node("AnimationPlayer").play("open")
	yield(get_tree().create_timer(3.0), "timeout")
	Transition.get_node("AnimationPlayer").play("close")
	yield(get_tree().create_timer(3.0), "timeout")
	Transition.get_node("AnimationPlayer").play("open")
	yield(get_tree().create_timer(3.0), "timeout")
	Transition.get_node("AnimationPlayer").play("close")
	yield(get_tree().create_timer(3.0), "timeout")
	Transition.get_node("AnimationPlayer").play("open")
