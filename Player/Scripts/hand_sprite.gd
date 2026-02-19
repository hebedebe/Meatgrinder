extends Sprite2D

@export var open_hand_sprite: Texture2D;
@export var closed_hand_sprite: Texture2D;

func _process(_delta: float) -> void:
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		texture = closed_hand_sprite;
	else:
		texture = open_hand_sprite
