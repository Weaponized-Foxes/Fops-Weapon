extends CharacterBody2D

@export var health = 40

func damage(dmg: int):
	health -= dmg
	if health <= 0:
		die()

func die():
	queue_free()
