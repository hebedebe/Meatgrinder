extends Node

@onready var camera = $".."

const ACCELERATION_SPEED = 10000;
const DRAG = 10;

var velocity : Vector2 = Vector2(0,0);

func _process(delta: float) -> void:
	var horizontal_input = Input.get_axis("left", "right");
	var vertical_input = Input.get_axis("up", "down");
	var movement_direction = Vector2(horizontal_input, vertical_input).normalized();
	
	velocity += movement_direction * delta * ACCELERATION_SPEED;
	camera.position += velocity * delta;
	velocity -= velocity * DRAG * delta;
	
