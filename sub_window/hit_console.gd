extends Node2D

var hands = []
func _ready():
	$Hit.visible = false
	for child in $Hand.get_children():
		hands.push_back(child)

func shake():
	_select_hand(randi() % 3)
	$AnimationPlayer.play("beat")


func _select_hand(value):
	for i in hands.size():
		hands[i].visible = (i == value)
