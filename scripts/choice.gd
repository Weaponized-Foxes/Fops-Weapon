extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ChoiceFox.button_down.connect(func(): on_choice_pressed("ChoiceFox"))
	%ChoiceArctic.button_down.connect(func(): on_choice_pressed("ChoiceArctic"))
	%ChoiceToxic.button_down.connect(func(): on_choice_pressed("ChoiceToxic"))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_choice_pressed(ButtonName: String):
	print(ButtonName)
	if ButtonName == "ChoiceFox":
		Global.set_subClass("Fox")
		Global.paused = false
		queue_free()
	elif ButtonName == "ChoiceArctic":
		Global.set_subClass("Arctic Fox")
		Global.paused = false
		queue_free()
	elif ButtonName == "ChoiceToxic":
		Global.set_subClass("Toxic Fox")
		Global.paused = false
		queue_free()
	pass