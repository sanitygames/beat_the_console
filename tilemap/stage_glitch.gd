extends Sprite

func _ready():
	randomize()
	$Timer.wait_time = randf() / 2.0
	var _e = $Timer.connect("timeout", self, "_on_timeout")
	frame = randi() % 4
	$Timer.start()


func _on_timeout():
	queue_free()

