extends TextureRect

var value = 0.0

func _process(delta):
	value -= delta
	value = max(0.0, value)
	material.set_shader_param("distort_intensity", value)


func _on_Player_shake():
	value = 0.1

