extends CanvasLayer
var forSaleDefault = [
	powerUp.new("Player Health Up", "Increase player health by 100", 100, "Health", [], 100),
	powerUp.new("Player Speed Up", "Increase player speed by 50", 50, "Speed", [], 100),
	powerUp.new("Bite Melee", "Increase player Melee damage by 10", 10, "Melee", [], 100),
	powerUp.new("Tax Collector", "Increase player coin pickup multipler by 10", 10, "Money", [], 100)
]
#Place holder for now
var forSaleArctic = [
	powerUp.new("Player Health Up A", "Increase player health by 100", 100, "Health", [], 100),
	powerUp.new("Player Speed Up A", "Increase player speed by 50", 50, "Speed", [], 100),
	powerUp.new("Bite Melee A", "Increase player Melee damage by 10", 10, "Melee", [], 100),
	powerUp.new("Tax Collector A", "Increase player coin pickup multipler by 10", 10, "Money", [], 100)
]

#Place holder for now
var forSaleToxic = [
	powerUp.new("Player Health Up T", "Increase player health by 100", 100, "Health", [], 100),
	powerUp.new("Player Speed Up T", "Increase player speed by 50", 50, "Speed", [], 100),
	powerUp.new("Bite Melee T", "Increase player Melee damage by 10", 10, "Melee", [], 100),
	powerUp.new("Tax Collector T", "Increase player coin pickup multipler by 10", 10, "Money", [], 100)
]


var currentSelling = [
	powerUp.new("nul", "null", 0, "Melee", [], 0),
	powerUp.new("nul", "null", 0, "Melee", [], 0),
	powerUp.new("nul", "null", 0, "Melee", [], 0),
]
var rng = RandomNumberGenerator.new()


func setBuy1(power: powerUp):
	%Title1.set_text("[center]"+ power.powerName +"[/center]")
	%Description1.set_text("\n[center]"+ power.powerDescription +"[/center]\n\n" +
							"[center]Cost:\n"+ str(power.powerCost) + "[/center]")
	currentSelling[0] = power
	pass

func setBuy2(power: powerUp):
	%Title2.set_text("[center]"+ power.powerName +"[/center]")
	%Description2.set_text("\n[center]"+ power.powerDescription +"[/center]\n\n" +
							"[center]Cost:\n"+ str(power.powerCost) + "[/center]")
	currentSelling[1] = power
	pass

func setBuy3(power: powerUp):
	%Title3.set_text("[center]"+ power.powerName +"[/center]")
	%Description3.set_text("\n[center]"+ power.powerDescription +"[/center]\n\n" +
							"[center]Cost:\n"+ str(power.powerCost) + "[/center]")
	currentSelling[2] = power
	pass


func SetupShopDefault():
	rng.randomize()
	var random1 = rng.randi_range(0, forSaleDefault.size()-1)
	var random2 = rng.randi_range(0, forSaleDefault.size()-1)
	var random3 = rng.randi_range(0, forSaleDefault.size()-1)
	setBuy1(forSaleDefault[random1])
	setBuy2(forSaleDefault[random2])
	setBuy3(forSaleDefault[random3])
	pass

func SetupShopArctic():
	rng.randomize()
	var random1 = rng.randi_range(0, forSaleArctic.size()-1)
	var random2 = rng.randi_range(0, forSaleArctic.size()-1)
	var random3 = rng.randi_range(0, forSaleArctic.size()-1)
	setBuy1(forSaleArctic[random1])
	setBuy2(forSaleArctic[random2])
	setBuy3(forSaleArctic[random3])
	pass


func SetupShopToxic():
	rng.randomize()
	var random1 = rng.randi_range(0, forSaleToxic.size()-1)
	var random2 = rng.randi_range(0, forSaleToxic.size()-1)
	var random3 = rng.randi_range(0, forSaleToxic.size()-1)
	setBuy1(forSaleToxic[random1])
	setBuy2(forSaleToxic[random2])
	setBuy3(forSaleToxic[random3])
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.paused = true
	%Button1.button_down.connect(func(): on_buy_pressed("Button 1"))
	%Button2.button_down.connect(func(): on_buy_pressed("Button 2"))
	%Button3.button_down.connect(func(): on_buy_pressed("Button 3"))
	match Global.subClass:
		"Fox":
			SetupShopDefault()
		"Arctic Fox":
			SetupShopArctic()
		"Toxic Fox":
			SetupShopToxic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Global.paused = false
		queue_free()
	pass


func on_buy_pressed(ButtonName: String):
	if ButtonName == "Button 1":
		if currentSelling[0].powerCost <= Global.money:
			Global.sub_money(currentSelling[0].powerCost)
			Global.add_powerUp(currentSelling[0])
			_ready()
		else:
			print("Not enough money")
	elif ButtonName == "Button 2":
		if currentSelling[1].powerCost <= Global.money:
			Global.sub_money(currentSelling[1].powerCost)
			Global.add_powerUp(currentSelling[1])
			_ready()
		else:
			print("Not enough money")
	elif ButtonName == "Button 3":
		if currentSelling[2].powerCost <= Global.money:
			Global.sub_money(currentSelling[2].powerCost)
			Global.add_powerUp(currentSelling[2])
			_ready()
		else:
			print("Not enough money")
	pass
