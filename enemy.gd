extends CharacterBody2D

@export var health = 40

func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health

func damage(dmg: int):
	health -= dmg
	$HealthBar.value = health
	if health <= 0:
		die()

func die():
	queue_free()
