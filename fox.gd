extends CharacterBody2D

enum FoxType {Default, Arctic}

@export var speed = 400
@export var type = FoxType.Default

func _ready() -> void:
	if type == FoxType.Arctic:
		update_texture(preload("res://Arctic Fox Sprite Sheet.png"))

func _process(delta: float) -> void:
	pass	

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
			update_texture(preload("res://Arctic Fox Sprite Sheet.png"))
		elif type == FoxType.Arctic:
			type = FoxType.Default
			update_texture(preload("res://Fox Sprite Sheet.png"))

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
