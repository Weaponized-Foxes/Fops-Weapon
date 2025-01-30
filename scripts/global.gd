extends Node
var money = 0
var powerUpActive = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#adds money
func add_money(add: int) -> void:
	money += add
	pass

#removes money
func sub_money(sub: int) -> bool:
	if (money-sub) <= 0:
		return false
	money -= sub
	return true

func add_powerUp(power: powerUp) -> void:
	powerUpActive.append(power)
	pass

func sub_powerUp(power: powerUp) -> void:
	powerUpActive.remove(power)
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
