extends "res://scripts/melee_enemy.gd"

@export var spin_speed = 30

func _process(delta: float) -> void:
	super._process(delta)
	if $Sprite.animation == "attack" && $Sprite.frame == 6:
		if flipped:
			rotation_degrees -= spin_speed
		else:
			rotation_degrees += spin_speed
	else:
		rotation_degrees = 0
