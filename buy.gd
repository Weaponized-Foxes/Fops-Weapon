extends Button


func _ready() -> void:
	pass # Replace with function body.


func _pressed():
	get_parent().get_parent().get_parent().get_parent().call('_on_buy_pressed', get_name())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
