extends Node2D

func shake():
	$AnimationPlayer.play("shake")


func _on_Player_shake():
	$AnimationPlayer.play("shake")
