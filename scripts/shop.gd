extends CanvasLayer
var forSale = [
	powerUp.new("Player Health Up", "Increase player health by 100", 100, "Health", [], 100),
	powerUp.new("Player Speed Up", "Increase player speed by 50", 50, "Speed", [], 100),
	powerUp.new("Bite Melee", "Increase player Melee damage by 10", 10, "Melee", [], 100),
	powerUp.new("Tax Collector", "Increase player coin pickup multipler by 10", 10, "Money", [], 100)
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Button1.button_down.connect(func(): on_buy_pressed("Button 1"))
	%Button2.button_down.connect(func(): on_buy_pressed("Button 2"))
	%Button3.button_down.connect(func(): on_buy_pressed("Button 3"))
	print(forSale)
	print("Shop Ready")
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
	pass


func on_buy_pressed(ButtonName: String):
	print(ButtonName)
	pass
