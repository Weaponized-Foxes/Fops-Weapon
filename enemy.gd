extends CharacterBody2D

@export var health = 40
@export var speed = 170;

func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health

func _process(delta: float) -> void:
	if $Sprite.animation == "damage" && $Sprite.is_playing():
		return
	if health <= 0:
		if not $Sprite.is_playing():
			queue_free()
	else:
		ai()
		move_and_slide()

func damage(dmg: int):
	health -= dmg
	$HealthBar.value = health
	$Sprite.play("damage")
	if health <= 0:
		die()

func die():
	$Sprite.play("die")

func move_to_player():
	var direction = %Fox.global_position - global_position
	velocity = direction.normalized() * speed

func ai():
	# print(name + " is thinking...")
	pass
