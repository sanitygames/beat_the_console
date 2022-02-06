extends Node

enum GameState {GAME}
enum InputDirection {NONE, LEFT, RIGHT}
enum InputAction {NONE, JUMP}

var input_direction = InputDirection.NONE
var input_action = InputAction.NONE
var game_state = GameState.GAME

func _process(_delta):
	if Input.is_action_pressed("retry"):
		get_tree().reload_current_scene()

