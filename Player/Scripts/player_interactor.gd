extends Node2D

@onready var hand_sprite = $"HandSprite"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position();
	global_position = mouse_pos; 
