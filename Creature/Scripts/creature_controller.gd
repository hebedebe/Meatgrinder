class_name Creature
extends Node2D

const DEFAULT_VALUE: float = 100;

const VOMIT_FOOD_LOSS: float = 15

#region Depletion rates
const DEPLETION_VARIANCE: float = 1;
const FOOD_DEPLETION_RATE: float = 1;
const SLEEP_DEPLETION_RATE: float = 1;
#endregion

#region State thresholds
const EATING_THRESHOLD: float = 30;
const HUNGER_MURDER_THRESHOLD: float = 10;
#endregion

#region necessities
var food: float = 10;
var fear: float = DEFAULT_VALUE;
var sleep: float = DEFAULT_VALUE;
var health: float = DEFAULT_VALUE;
#endregion

#region references
@onready var state_machine: CreatureStateMachine = $CreatureStateMachine
@onready var creature_navigator: CreatureNavigator = $CreatureNavigator
@onready var creature_awareness: CreatureAwareness = $CreatureAwareness
#endregion

func _ready() -> void:
	call_deferred("init") #generate the terrain around the creature
	
func init():
	creature_navigator.set_target_position(global_position)

func _process(delta: float) -> void:
	var variance = randf_range(-DEPLETION_VARIANCE, DEPLETION_VARIANCE);
	food -= (FOOD_DEPLETION_RATE + variance) * delta
	sleep -= (SLEEP_DEPLETION_RATE + variance) * delta
	
	if check_necessities():
		die()
	
func check_necessities() -> bool:
	return food < 0 or sleep < 0 or health < 0
	
func damage(amount: float):
	#print("damaged for ", amount)
	$CreatureSprite.tint(Color(1.0, 0.0, 0.0, 1.0))
	health -= amount;
	
func die():
	print("Died")
	var food: Food = preload("res://Food/Variants/corpse.tscn").instantiate()
	get_parent().add_child(food);
	food.global_position = global_position
	queue_free()
	
func vomit():
	var vom = preload("res://Food/Variants/vomit.tscn").instantiate()
	get_parent().add_child(vom)
	vom.global_position = global_position
	food -= VOMIT_FOOD_LOSS;
	#also spawn vomit puddle here
