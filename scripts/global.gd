extends Node
var money = 20000000000000
var multiplier_money = 1.00
var powerUpActive = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#adds money
func add_money(add: int) -> void:
	money += add*multiplier_money
	pass

#removes money
func sub_money(sub: int) -> bool:
	if (money-sub) <= 0:
		return false
	money -= sub
	return true

func add_powerUp(power: powerUp) -> void:
	var FoxScript = get_node("/root/Node2D/Fox")
	match power.powerType:
		"Melee":
			FoxScript.atttackDamage += power.powerModifier
			# Code for meele power-up
		"Health":
			FoxScript.healthUp(power.powerModifier)
			# Code for health power-up
		"Speed":
			FoxScript.speed += power.powerModifier
			# Code for speed power-up
		"Money":
			Global.multiplier_money *= (power.powerModifier / 100.0)
			# Code for money power-up
	powerUpActive.append(power)
	print(powerUpActive)
	pass

func sub_powerUp(power: powerUp) -> void:
	powerUpActive.remove(power)
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
