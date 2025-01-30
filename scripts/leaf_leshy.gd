extends "res://scripts/enemy.gd"

@export var seed_speed = 120
@export var seed_damage = 10

var seedScene = preload("res://scenes/seed.tscn")

func _ready() -> void:
	super._ready()
	$Sprite.animation_finished.connect(spawn_seed)

func _process(delta: float) -> void:
	if $Sprite.animation == "throw" && $Sprite.is_playing():
		return
	super._process(delta)

func ai():
	var sqr_dist_to_fox = (%Fox.global_position - global_position).length_squared()
	if sqr_dist_to_fox > 40000:
		move_to_player()
	else:
		throw()

func throw():
	$Sprite.play("throw")

func spawn_seed():
	if $Sprite.animation != "throw":
		return
	var instance = seedScene.instantiate()
	get_tree().root.add_child(instance)
	instance.velocity = (%Fox.global_position - global_position).normalized() * seed_speed
	instance.damage = seed_damage
	instance.global_position = global_position
