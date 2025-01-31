extends "res://scripts/melee_enemy.gd"

func damage(dmg: int, dmgType: String):
	super.damage(dmg, dmgType)
	if dmgType.contains("melee"):
		%Fox.damage(10)
