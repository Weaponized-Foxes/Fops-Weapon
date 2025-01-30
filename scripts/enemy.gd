extends CharacterBody2D

@export var max_health = 40
@export var speed = 170;

func _ready() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health

func _process(delta: float) -> void:
	if $Sprite.animation == "damage" && $Sprite.is_playing():
		return
	look_at_player()
	if $HealthBar.value <= 0:
		if not $Sprite.is_playing():
			queue_free()
	else:
		ai()
		move_and_slide()

func damage(dmg: int, dmgType: String):
	$HealthBar.value -= dmg
	$Sprite.play("damage")
	if $HealthBar.value <= 0:
		die()

func die():
	$Sprite.play("die")

func move_to_player():
	var direction = %Fox.global_position - global_position
	velocity = direction.normalized() * speed

func look_at_player():
	var direction = %Fox.global_position - global_position
	if direction.x > 0:
		$Sprite.flip_h = false
	elif direction.x < 0:
		$Sprite.flip_h = true

func ai():
	# print(name + " is thinking...")
	pass
