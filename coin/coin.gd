extends RigidBody2D

var coin_manager

func _ready():
	var _e = get_node("../Player").connect("shake", self, "_on_player_shake")
	coin_manager = get_node("../CoinManager")

func _on_player_shake():
	if coin_manager.count < 512:
		var c = duplicate()
		get_parent().add_child(c)
		coin_manager.count += 1


