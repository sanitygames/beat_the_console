extends StaticBody2D

func _ready():
	$Sprite.frame = randi() % 8
