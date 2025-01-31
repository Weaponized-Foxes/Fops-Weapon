extends "res://scripts/enemy.gd"

@export var hit_frame = 6
var damaged

func _ready() -> void:
    $Sprite.animation_finished.connect(func(): damaged = false)
    super._ready()

func _process(delta: float) -> void:
    if $Sprite.animation == "attack" && $Sprite.is_playing() && $Sprite.frame == hit_frame:
        for fox in $Slash.get_overlapping_bodies():
            if damaged:
                continue
            fox.damage(attack_damage)
            damaged = true
    super._process(delta)

func ai():
    if $AttackArea.has_overlapping_bodies():
        $Sprite.play("attack")
    else:
        move_to_player()

