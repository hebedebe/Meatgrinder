class_name FoodArea
extends Area2D

@onready var food: Food = $".."

func get_food() -> Food:
	return food;
