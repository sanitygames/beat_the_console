################################################################################
# player.gd
# プレイヤー用
################################################################################

extends KinematicBody2D

signal shake
signal door_entered

export (float) var speed = 10.0
export (float) var jump_power = 100.0
export (float) var g = 10.0

export (PackedScene) var player_glitch

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	for child in get_parent().get_children():
		if child.is_in_group("key"):
			var _e = connect("shake", child, "_on_player_shake")

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
			position.y = int(round(position.y))/8 * 8
			var _pg = player_glitch.instance()
			_pg.position = position
			get_node("../Glitch").add_child(_pg)
			position.y -= 16.0
			velocity.y = -jump_power
			$GlitchSound.play()

			emit_signal("shake")



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





func _on_EnterDoor_area_entered(_area:Area2D):
	## test code
	emit_signal("door_entered")
	if _area.owner.is_close:
		return
	print("enter@player")
	set_process(false)
	set_physics_process(false)
	$ClearSound.play()
	var a = 1.0
	while a > 0.0:
		a -= 0.01
		modulate.a = a
		yield(get_tree(), "idle_frame")
	yield(get_tree().create_timer(1.0), "timeout")
	Global.transition_start()



func _on_EnterNeedle_body_entered(_body:Node):
	$DeathSound.play()
	set_physics_process(false)
	var destroy_effect = Global.get_destroy_effect()
	get_parent().add_child(destroy_effect)
	destroy_effect.position = position
	destroy_effect.emitting = true
	visible = false
	yield(get_tree().create_timer(1.0), "timeout")
	var _e = get_tree().reload_current_scene()


