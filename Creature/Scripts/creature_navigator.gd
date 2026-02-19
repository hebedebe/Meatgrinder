class_name CreatureNavigator
extends Node2D

var movement_speed: float = 0; #will get set by states

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var creature: CharacterBody2D = $".."

func set_target_position(target_position: Vector2) -> void:
	get_tree().get_first_node_in_group("navigation").populate_location(target_position)
	navigation_agent.target_position = target_position
	
func get_target_position() -> Vector2:
	return navigation_agent.target_position
	
func get_next_path_position() -> Vector2:
	var next_position = navigation_agent.get_next_path_position()
	get_tree().get_first_node_in_group("navigation").populate_location(next_position)
	return next_position

func stop_pathfinding():
	navigation_agent.target_position = creature.global_position

func is_finished() -> bool:
	return navigation_agent.is_navigation_finished();

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished(): return;
	
	var current_agent_position = global_position;
	var next_path_position = navigation_agent.get_next_path_position();
	creature.velocity = current_agent_position.direction_to(next_path_position) * movement_speed;
	
	creature.move_and_slide();
