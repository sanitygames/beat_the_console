extends Node2D

var key_count = 0
var is_close = false

func on_key_body_entered(_body):
	sub_key()

func sub_key():
	key_count -= 1
	if key_count == 0:
		$Close.visible = false
		$Open.visible = true
		is_close = false


func add_key():
	key_count += 1
	if key_count != 0:
		$Close.visible = true
		$Open.visible = false
		is_close = true
