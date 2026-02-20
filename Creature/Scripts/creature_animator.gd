class_name CreatureAnimator
extends AnimatedSprite2D

const TINT_REVERT_SPEED: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("default")

func tint(color: Color):
	modulate = color

func _process(delta: float) -> void:
	modulate = modulate.lerp(Color(1.0, 1.0, 1.0, 1.0), TINT_REVERT_SPEED * delta)
