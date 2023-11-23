extends Node

signal lost

@onready var player: CharacterBody2D = $Player
@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var projectile: RigidBody2D = preload("res://scenes/projectile.tscn").instantiate()
@onready var music: AudioStreamPlayer = $Sounds/Background

@onready var gets_harder: Timer = $Gets_harder
@onready var spawn: Timer = $MobSpawn
@onready var mob_spawn_location: PathFollow2D = $Spawn_path/Follow
var hardnes: int = 0
@onready var enemies =[
	preload("res://scenes/gargoyle.tscn"),
	preload("res://scenes/ghost.tscn")
]

@export var currentHealthUpgrade = 0
@export var maxHealthIncrement = 5

func _ready() -> void:
	player.position = player_start_position.position
	$HealthIcon/healthvalue.text = str($Player.Health)
func _process(delta):
	$HealthIcon/healthvalue.text = str($Player.Health)

func game_over():
	lost.emit()
	player.Health = 3
	player.shot_number = 1
	player.damage=10
	player.upgrade_options.clear()
	player.collected_upgrades.clear()
	player.get_node("ProgressionSystem").current_level = 0
	player.get_node("ProgressionSystem").current_xp = 0
	player.get_node("ProgressionSystem").xp_needed_for_next_level = 10
	projectile.set_script(load("res://scripts/player/projectile.gd"))
	player.get_node("Immunity").stop()
	player.position = player_start_position.position
	spawn.stop()
	music.stop()
	gets_harder.stop()
	spawn.wait_time = 3
	hardnes = 0
	get_tree().call_group("enemies","queue_free")



func start_game():
	player.Health = 3
	player.position = player_start_position.position
	spawn.start()
	gets_harder.start()
	if(!music.playing):
		music.play() # Replace with function body.


func mob_spawn():
	var mob = enemies[randi_range(0, enemies.size()-1)].instantiate()
	currentHealthUpgrade += randi_range(0, maxHealthIncrement)
	mob.add_health(currentHealthUpgrade)
	mob_spawn_location.progress_ratio = randf_range(0,1)
	mob.position = mob_spawn_location.position
	mob.health = mob.BaseHealth * (hardnes+1)
		
	add_child(mob.duplicate())


func _on_gets_harder():
	spawn.wait_time *= 0.8
	hardnes +=1
