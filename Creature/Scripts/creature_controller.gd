class_name Creature
extends Node2D

const DEFAULT_VALUE: float = 35;

#region Depletion rates
const FOOD_DEPLETION_RATE: float = 1;
const SLEEP_DEPLETION_RATE: float = 1;
#endregion

#region State thresholds
const EATING_THRESHOLD: float = 30;
const CANNIBALISE_THRESHOLD: float = 10;
#endregion

#region necessities
var food: float = DEFAULT_VALUE;
var fear: float = DEFAULT_VALUE;
var sleep: float = DEFAULT_VALUE;
#endregion


func _process(delta: float) -> void:
	food -= FOOD_DEPLETION_RATE * delta
	sleep -= SLEEP_DEPLETION_RATE * delta
