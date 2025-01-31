extends "res://scripts/enemy.gd"

@export var seed_speed = 120

var seedScene = preload("res://scenes/seed.tscn")

func _ready() -> void:
	super._ready()
	$Sprite.animation_finished.connect(spawn_seed)

func ai():
	var sqr_dist_to_fox = (%Fox.global_position - global_position).length_squared()
	if sqr_dist_to_fox > 40000:
		move_to_player()
	else:
		throw()

func damage(dmg: int, dmgType: String):
	if dmgType.contains("fire"):
		dmg *= 1.5
	super.damage(dmg, dmgType)

func throw():
	$Sprite.play("attack")

func spawn_seed():
	if $Sprite.animation != "attack":
		return
	var instance = seedScene.instantiate()
	get_tree().root.add_child(instance)
	instance.velocity = (%Fox.global_position - global_position).normalized() * seed_speed
	instance.damage = attack_damage
	instance.global_position = global_position
