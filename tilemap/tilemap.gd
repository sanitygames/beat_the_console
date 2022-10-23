extends TileMap

export (PackedScene) var stage_glitch


func _on_Player_shake():
	var used_cells = get_used_cells()
	print(get_used_rect())
	for i in 30:
		var ri = randi() % used_cells.size()
		var _gl = stage_glitch.instance()
		_gl.position = used_cells[ri] * 8.0 + Vector2(4.0, 4.0)
		add_child(_gl)
