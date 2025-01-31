extends CharacterBody2D

@export var max_health = 40
@export var speed = 170
@export var attack_damage = 10
var flipped

func _ready() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health

func _process(delta: float) -> void:
	if Global.paused:
		return
	if ($Sprite.animation == "damage" || $Sprite.animation == "attack") && $Sprite.is_playing():
		return
	if $HealthBar.value <= 0:
		if not $Sprite.is_playing():
			queue_free()
	else:
		ai()
		move_and_slide()
	look_at_player()

func damage(dmg: int, dmgType: String):
	$HealthBar.value -= dmg
	if ($Sprite.animation != "attack"):
		$Sprite.play("damage")
	if $HealthBar.value <= 0:
		die()

func die():
	collision_layer = 0
	$Sprite.play("die")

func move_to_player():
	var direction = %Fox.global_position - global_position
	velocity = direction.normalized() * speed
	$Sprite.play("walk")

func look_at_player():
	var direction = %Fox.global_position - global_position
	if direction.x > 0:
		flip(false)
	elif direction.x < 0:
		flip(true)

func ai():
	# print(name + " is thinking...")
	pass

func flip(_flipped: bool):
	flipped = _flipped
	if flipped:
		scale = Vector2(-4, 4)
	else:
		scale = Vector2(4, 4)
	rotation = 0