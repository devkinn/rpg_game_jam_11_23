extends Node

signal level_up

@export var a: float = 0.5
@export var b: float = 1.4
@export var c: float = 15.0

var current_level: int = 0
var current_xp: int = 0
var xp_needed_for_next_level: int = 10


func _ready() -> void:
	xp_needed_for_next_level = calculate_next_level_xp_cap(current_level + 1)

func add_xp(xp: int) -> void:
	current_xp += xp
	if current_xp >= xp_needed_for_next_level:
		add_level()

func add_level() -> void:
	current_xp = 0
	current_level += 1
	xp_needed_for_next_level = calculate_next_level_xp_cap(current_level + 1)
	level_up.emit()

# Leveling up based on exponential curve
func calculate_next_level_xp_cap(level: int) -> int:
	return roundi(a * pow(b, level) + c)
