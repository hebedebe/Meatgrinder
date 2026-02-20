class_name WanderingState
extends CreatureState

const WANDER_DELAY: float = 5;
const WANDER_VARIANCE: float = 2;
const WANDER_DISTANCE: float = 200;
const WANDER_SPEED: float = 100;
#const MIN_WANDER_TIME: float = 1;

@onready var wander_timer = $WanderTimer
@onready var creature_navigator: CreatureNavigator = $"../../CreatureNavigator"
@onready var creature_awareness  = $"../../CreatureAwareness"

func _ready() -> void:
	creature_awareness.connect("area_entered", creature_awareness_entered)
	wander_timer.connect("timeout", wander_timeout)
	#navigation_agent.connect("destination_reached", wander_timeout)

func on_enter():
	creature_navigator.movement_speed = WANDER_SPEED
	wander_timeout()
	
func on_process(_delta: float):
	if creature.food < creature.EATING_THRESHOLD:
		state_machine.set_state($"../Eating")
	
func on_exit():
	wander_timer.stop();

func scramble_wander_time():
	wander_timer.wait_time = WANDER_DELAY + randf_range(-WANDER_VARIANCE, WANDER_VARIANCE)

func wander_timeout():
	if !is_active(): 
		return
	#print("Wander timeout")
	if creature_navigator.is_finished():
		var wander_offset = Vector2(randf_range(-WANDER_DISTANCE, WANDER_DISTANCE), randf_range(-WANDER_DISTANCE, WANDER_DISTANCE));
		creature_navigator.set_target_position(creature.global_position + wander_offset)
	scramble_wander_time();
	wander_timer.start();

func creature_awareness_entered(_area: Area2D):
	#print(area)
	pass
