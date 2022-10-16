################################################################################
# player.gd
# プレイヤー用
################################################################################

extends KinematicBody2D

export (float) var speed = 10.0
export (float) var jump_power = 100.0
export (float) var g = 10.0

export (PackedScene) var player_glitch

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO

onready var game_window = get_node("../")

func _process(_delta):
	if Input.is_action_pressed("left"):
		input_direction = Vector2.LEFT
	elif Input.is_action_pressed("right"):
		input_direction = Vector2.RIGHT

	else:
		input_direction = Vector2.ZERO

	if Input.is_action_just_pressed("glitch"):
		if $CheckFloorCast.is_colliding() && !$CheckUpCast.is_colliding():
			var tuned_x = (int(floor(position.x))/8) * 8 + 4
			position.x = tuned_x
			var _pg = player_glitch.instance()
			_pg.position = position
			get_parent().add_child(_pg)
			position.y -= 16.0
			velocity.y = -jump_power
			game_window.shake()



func _physics_process(delta):
	velocity.y += g * delta
	velocity.x = input_direction.x * speed
	var _col = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		velocity.y = 0.0
		if velocity.x == 0.0:
			$AnimatedSprite.animation = "idle"
		elif velocity.x > 0.0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.scale.x = 1
		else:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.scale.x = -1

	else:
		$AnimatedSprite.animation = "jump"



