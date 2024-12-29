extends Node3D
class_name HealthComponent

@export var MaxHealth := 10
var health : float

func _ready():
	health = MaxHealth

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()
