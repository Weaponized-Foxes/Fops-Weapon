extends Node2D

class_name powerUp

var powerName = ""
var powerDescription = ""
var powerCost = 0
var powerType = ""
var powerRequirements = []
var powerModifier = 0

func _init(powerName: String, powerDescription: String, powerCost: int, powerType: String, powerRequirements: Array, powerModifier: int) -> void:
	self.powerName = powerName
	self.powerDescription = powerDescription
	self.powerCost = powerCost
	self.powerType = powerType
	self.powerRequirements = powerRequirements
	self.powerModifier = powerModifier
