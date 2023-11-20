extends Node

signal lost

@onready var player: CharacterBody2D = $Player
@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var projectile: RigidBody2D = preload("res://scenes/projectile.tscn").instantiate()
func _ready() -> void:
	player.position = player_start_position.position
	$HealthIcon/healthvalue.text = str($Player.Health)
func _process(delta):
	$HealthIcon/healthvalue.text = str($Player.Health)

func game_over():
	lost.emit()
	player.Health = 3
	player.shot_number = 1
	player.upgrade_options.clear()
	player.collected_upgrades.clear()
	player.get_node("ProgressionSystem").current_level = 0
	player.get_node("ProgressionSystem").current_xp = 0
	player.get_node("ProgressionSystem").xp_needed_for_next_level = 10
	projectile.set_script(load("res://scripts/player/projectile.gd"))
	player.get_node("Immunity").stop()
	player.position = player_start_position.position
	
	

