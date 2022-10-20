extends Area2D

var speed = 100
var g = 200

func _ready():
	var door = get_node("../Door")
	var _e = connect("body_entered", door, "on_key_body_entered")
	_e = connect("body_entered", self, "_on_key_body_entered")
	door.add_key()

func _on_key_body_entered(_body):
	queue_free()




func _on_player_shake():
	pass
