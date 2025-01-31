extends Node
var money = 20000000000000
var multiplier_money = 1.00
var characterLevel = 0
var subClass = "Fox"
var powerUpActive = []
var paused = false
var choice = false

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

func set_subClass(sub: String) -> void:
	var FoxScript = get_node("/root/Node2D/Fox")
	var FoxType = FoxScript.FoxType
	subClass = sub
	match sub:
		"Fox":
			# Code for Fox
			FoxScript.type = FoxType.Default
		"Arctic Fox":
			# Code for Arctic Fox
			FoxScript.type = FoxType.Arctic
		"Toxic Fox":
			# Code for Toxic Fox
			FoxScript.type = FoxType.Toxic
	FoxScript.update_fox()
	pass


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
	characterLevel = len(powerUpActive)
	pass

func sub_powerUp(power: powerUp) -> void:
	powerUpActive.remove(power)
	characterLevel = len(powerUpActive)
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
