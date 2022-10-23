extends KinematicBody2D

var speed = 400
var g = 30

export (PackedScene) var glitch

var velocity = Vector2.ZERO
var door
var is_active = true

func _ready():
	door = get_node("../Door")
	var _e = $Area2D.connect("body_entered", self, "_on_key_body_entered")
	_e = get_node("../Player").connect("shake", self, "_on_player_shake")
	door.add_key()

func _physics_process(_delta):
	if !is_on_floor():
		velocity += Vector2.DOWN * g

	var _col = move_and_slide(velocity, Vector2.UP)

func _on_key_body_entered(_body):
	if is_active:
		door.on_key_body_entered()
		is_active = false
		$AudioStreamPlayer.play()
		visible = false
		yield($AudioStreamPlayer, "finished")
		queue_free()




func _on_player_shake():
	if is_on_floor() && is_active && !$RayCast2D.is_colliding():
		print("XXX")
		var _gl = glitch.instance()
		_gl.position = position
		get_parent().add_child(_gl)
		position.y -= 8.0
		velocity = Vector2.UP * speed
