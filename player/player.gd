################################################################################
# player.gd
# プレイヤー用
################################################################################

extends KinematicBody2D

export (float) var speed = 10.0
export (float) var g = 10.0

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _process(_delta):
	if Input.is_action_pressed("left"):
		input_direction = Vector2.LEFT
	elif Input.is_action_pressed("right"):
		input_direction = Vector2.RIGHT
	else:
		input_direction = Vector2.ZERO

func _physics_process(delta):
	velocity.y += g * delta
	velocity.x = input_direction.x * speed
	var _col = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
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



