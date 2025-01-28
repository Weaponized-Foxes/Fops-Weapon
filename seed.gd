extends Area2D

var velocity: Vector2

func _ready():
	body_entered.connect(hit)

func _process(delta: float) -> void:
	global_position += velocity * delta
	pass

func hit(body):
	queue_free()