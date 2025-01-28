extends CharacterBody2D
@export var speed = 400
@export var sprite: AnimatedSprite2D
@export var arctic = false



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func get_input() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	if direction.length_squared() > 0:
		sprite.play("run")
	else:
		sprite.play("idle")
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		
	if Input.is_action_just_pressed("ability_1"):
		arctic = !arctic;
		if arctic:
			sprite.sprite_frames = preload("res://ArcticFoxFrames.tres")
		else:
			sprite.sprite_frames = preload("res://FoxFrames.tres")
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://shop.tscn")
	

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
