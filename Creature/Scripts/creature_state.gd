class_name CreatureState
extends Node

@onready var creature: Creature = $"../.."
@onready var state_machine: CreatureStateMachine = $".."

var active: bool = false

func state_enter():
	active = true;
	on_enter();
	
func state_process(delta: float):
	on_process(delta)
	
func state_exit():
	active = false
	on_exit();
	
func is_active() -> bool:
	return active;


#region Virtual functions
func on_enter():
	pass

func on_process(_delta: float):
	pass

func on_exit():
	pass
#endregion
