class_name CreatureNavigator
extends Node2D

var movement_speed: float = 0; #will get set by states

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var creature: CharacterBody2D = $".."

func get_populator() -> NavigationGenerator:
	return get_tree().get_first_node_in_group("navigation")

func set_target_position(target_position: Vector2) -> void:
	get_populator().populate_location(target_position)
	navigation_agent.target_position = target_position
	
func get_target_position() -> Vector2:
	return navigation_agent.target_position
	
func get_next_path_position() -> Vector2:
	var next_position = navigation_agent.get_next_path_position()
	get_populator().populate_location(next_position)
	return next_position

func stop_pathfinding():
	navigation_agent.target_position = creature.global_position

func is_finished() -> bool:
	return navigation_agent.is_navigation_finished();

func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished(): return;
	
	var current_agent_position = global_position;
	var next_path_position = navigation_agent.get_next_path_position();
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed;
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity_forced(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
	creature.move_and_slide();


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	creature.velocity = safe_velocity
