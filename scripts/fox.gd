extends CharacterBody2D

enum FoxType {Default, Arctic}

@export var max_health = 100
@export var speed = 200
@export var type = FoxType.Default
@export var attackSpeed = 0.5
@export var atttackDamage = 20
var shop = preload("res://scenes/shop.tscn")
var attackTimer = 0
var attackTimer = 0



func _ready() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
	if type == FoxType.Arctic:
		update_texture(preload("res://sprites/Arctic Fox Sprite Sheet.png"))

func _process(delta: float) -> void:
	handle_attacks(delta)

func handle_attacks(delta: float) -> void:
	attackTimer -= delta

	$Slash.look_at(get_global_mouse_position())

	if $Slash/Sprite.is_playing():
		if attackTimer < 0 and $Slash/Sprite.frame == 5: # middle of slash animation
			attackTimer = attackSpeed
			basic_attack()
	else:
		if Input.is_action_pressed("basic_attack"):
			if attackTimer < 0:
				$Slash/Sprite.play()

func basic_attack():
	for enemy in $Slash.get_overlapping_bodies():
		enemy.damage(atttackDamage)

func get_input() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	if direction.length_squared() > 0:
		$Sprite.play("run")
	else:
		$Sprite.play("idle")
	if direction.x > 0:
		$Sprite.flip_h = false
	elif direction.x < 0:
		$Sprite.flip_h = true

	if Input.is_action_just_pressed("ability_1"):
		if type == FoxType.Default:
			type = FoxType.Arctic
			update_texture(preload("res://sprites/Arctic Fox Sprite Sheet.png"))
		elif type == FoxType.Arctic:
			type = FoxType.Default
			update_texture(preload("res://sprites/Fox Sprite Sheet.png"))
	if Input.is_action_just_pressed("ui_accept"):
		var ShopInstantiate = shop.instantiate()
		get_tree().root.add_child.call_deferred(ShopInstantiate)

func damage(dmg: int):
	$HealthBar.value -= dmg

func update_texture(texture: Texture):
	var reference_frames: SpriteFrames = $Sprite.sprite_frames
	var updated_frames = SpriteFrames.new()

	for animation in reference_frames.get_animation_names():
		if animation != "default":
			updated_frames.add_animation(animation)
			updated_frames.set_animation_speed(animation, reference_frames.get_animation_speed(animation))
			updated_frames.set_animation_loop(animation, reference_frames.get_animation_loop(animation))

		for i in reference_frames.get_frame_count(animation):
			var updated_texture: AtlasTexture = reference_frames.get_frame_texture(animation, i).duplicate()
			updated_texture.atlas = texture
			updated_frames.add_frame(animation, updated_texture)

	updated_frames.remove_animation("default")

	$Sprite.sprite_frames = updated_frames

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
