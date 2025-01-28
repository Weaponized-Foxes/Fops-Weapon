extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var healthUp = powerUp.new("Player Health Up", "Increase player health by 100", 100, "Health", [], 100) 
	var testRequirements = []
	testRequirements.append(healthUp)
	var healthDown = powerUp.new("Player Health Down", "Decrease player health by 100", -100, "Health", testRequirements, 100)
	pass 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
	pass
