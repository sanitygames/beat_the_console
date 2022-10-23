extends WorldEnvironment

var time = 0.0

func _process(_delta):
	environment.glow_bloom = max(0.2, time * 1.0)
	time -= _delta
	time = max(time, 0.0)



func _on_Player_shake():
	time = 1.0
