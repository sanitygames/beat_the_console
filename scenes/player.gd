extends KinematicBody2D

export (float) var speed = 10.0
export (float) var jump_force1 = 100.0
export (float) var jump_force2 = 10.0
export (float) var gravity = 10.0

enum InputDirection {NONE, LEFT, RIGHT}
enum InputAction {NONE, JUMP, GLITCH}

enum State {NONE, WALK, AIR}

var input_direction = InputDirection.NONE
var input_action = InputAction.NONE

onready var glitch_prefab = preload("res://scenes/Glitch.tscn")
var state = State.NONE
var velocity = Vector2.ZERO

func _process(_delta):
	# Check input direction
	if Input.is_action_pressed("left"):
		input_direction = InputDirection.LEFT
	elif Input.is_action_pressed("right"):
		input_direction = InputDirection.RIGHT
	else:
		input_direction = InputDirection.NONE

	# Check input action
	if Input.is_action_just_pressed("jump"):
		input_action = InputAction.JUMP
	elif Input.is_action_just_pressed("glitch"):
		input_action = InputAction.GLITCH
	else:
		input_action = InputAction.NONE




func _physics_process(delta):
	# Check GameState
	if Global.game_state != Global.GameState.GAME:
		return

	# set horizontal velocity
	match input_direction:
		InputDirection.LEFT:
			velocity.x = -speed
		InputDirection.RIGHT:
			velocity.x = speed
		_:
			velocity.x = 0.0

	# execute actions
	match input_action:
		InputAction.JUMP:
			velocity.y = -jump_force1
		InputAction.GLITCH:
			glitch()
		_:
			pass

	# Calc gravity
	if is_on_floor():
		velocity.y = min(0.0, velocity.y)
	velocity.y += gravity * delta

	# Move Player
	var _collison = move_and_slide(velocity, Vector2.UP)

	# Round position.y
	if is_on_floor():
		global_position.y = round(global_position.y)

	_set_animation()

	
	
func _set_animation():
	var anim = get_node("AnimatedSprite")
	if is_on_floor(): 
		if velocity.x == 0.0:
			anim.play("idle")
		else:
			anim.play("walk")
	else:
		anim.play("jump")
	
	if velocity.x > 0.0:
		anim.scale.x = 1.0
	elif velocity.x < 0.0:
		anim.scale.x = -1.0




func glitch():
	var pos = _check_ground()
	if pos == Vector2.ZERO:
		return
	var _g = glitch_prefab.instance()
	_g.global_position = pos
	get_tree().root.get_node("TestScene").add_child(_g)
	global_position.y -= 16.0
	velocity.y = -jump_force1


func _check_ground() -> Vector2:
	var left_ray: RayCast2D = get_node("CheckGroundRays/Left")
	var right_ray: RayCast2D = get_node("CheckGroundRays/Right")
	var pos_x := 0.0
	if left_ray.is_colliding() && right_ray.is_colliding():
		pos_x = float(int(round(global_position.x)) / 8) * 8.0 + 4.0
		return Vector2(pos_x, global_position.y)
	else:
		return Vector2.ZERO



