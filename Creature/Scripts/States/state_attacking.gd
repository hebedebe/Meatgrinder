extends CreatureState

const DAMAGE: float = 100;
const DAMAGE_VARIANCE: float = 20;
const ATTACK_DISTANCE=30

@onready var creature_navigator: CreatureNavigator = $"../../CreatureNavigator"
@onready var creature_awareness: CreatureAwareness = $"../../CreatureAwareness"
@onready var creature_interaction: Area2D = $"../../CreatureInteraction"

var target_creature: Creature;

func on_enter():
	locate_target()

func _physics_process(delta: float) -> void:
	if not is_active(): return
	if not target_creature or not target_creature.is_inside_tree():
		state_machine.set_state($"../Wandering")
	if target_creature:
		creature_navigator.set_target_position(target_creature.global_position)
		var dist = target_creature.global_position.distance_squared_to(creature.global_position)
		if dist <= ATTACK_DISTANCE*ATTACK_DISTANCE:
			target_creature.damage((DAMAGE + randf_range(-DAMAGE_VARIANCE, DAMAGE_VARIANCE))*delta)

func locate_target():
	if target_creature and not target_creature.is_inside_tree():
		target_creature = null
	for body in creature_awareness.get_overlapping_bodies():
		if body is Creature and body != creature:
			if not target_creature:
				target_creature = body
			else:
				var distance = body.global_position.distance_squared_to(creature.global_position)
				if  distance < target_creature.global_position.distance_squared_to(creature.global_position):
					target_creature = body
