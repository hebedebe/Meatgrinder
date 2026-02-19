class_name CreatureStateMachine
extends Node

@export var current_state: CreatureState;

func _ready() -> void:
	if current_state:
		current_state.state_enter();

func _process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta);

func set_state(state: CreatureState):
	if current_state:
		current_state.state_exit();
	current_state = state;
	current_state.state_enter();
