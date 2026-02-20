class_name Food
extends Node2D

@export var satiation: float = 20;
@export var time_to_eat: float = 3;
@export var hunger_threshold: float = 100; #how hungry they would have to be to eat this

var eaten: bool = false

func eat(creature: Creature):
	eaten = true
	on_eaten(creature)
	queue_free()
	
func on_eaten(creature: Creature):
	pass
	
func is_eaten() -> bool:
	return eaten

func get_hunger_threshold() -> float:
	return hunger_threshold
