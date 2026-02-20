extends CreatureState

@onready var creature_awareness: CreatureAwareness = $"../../CreatureAwareness"
@onready var creature_interaction: Area2D = $"../../CreatureInteraction"
@onready var creature_navigator: CreatureNavigator = $"../../CreatureNavigator"

var target_food: Food;

func on_process(_delta: float):
	if creature.food > creature.EATING_THRESHOLD:
		creature_navigator.stop_pathfinding()
		state_machine.set_state($"../Wandering");
		return;
	
	#Find food
	var closest_food: Food;
	var closest_distance: float;
	
	var surrounding_areas = creature_awareness.get_overlapping_areas();
	for area in surrounding_areas:
		if area is FoodArea:
			var food = area.get_food()
			if food.eaten: continue
			if food.get_hunger_threshold() < creature.food: continue
			if not closest_food:
				closest_food = food;
				closest_distance = closest_food.global_position.distance_squared_to(creature.global_position)
			elif area.global_position.distance_squared_to(food.global_position) < closest_distance:
				closest_food = food;
				closest_distance = closest_food.global_position.distance_squared_to(creature.global_position)
	if closest_food and target_food != closest_food:
		creature_navigator.stop_pathfinding()
		target_food = closest_food
		
	if not target_food:
		if creature.food < creature.HUNGER_MURDER_THRESHOLD:
			state_machine.set_state($"../Attacking")
		else:
			state_machine.set_state($"../Wandering")
		return #start killing probably
	
	if creature_navigator.is_finished():
		creature_navigator.set_target_position(target_food.global_position)
		
		
func _physics_process(delta: float) -> void:
	if not is_active(): return
	for area in creature_interaction.get_overlapping_areas():
		if not area: continue
		if area is FoodArea:
			var food = area.get_food()
			await get_tree().create_timer(food.time_to_eat).timeout
			if not food or food.is_eaten(): 
				return
			creature.food += food.satiation
			food.eat(creature)
