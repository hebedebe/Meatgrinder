class_name Food
extends Node2D

@export var satiation: float = 20;

var eaten: bool = false

func eat():
	eaten = true
	queue_free()
	
func is_eaten() -> bool:
	return eaten
