extends Node


@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var player: CharacterBody2D = $Player
@onready var projectile_start_point: Marker2D = $Player/ProjectileStartPoint
@onready var shoot_cooldown: Timer = $ShootCooldown
@export var projectile_scene: PackedScene
@export var projectile_speed = 500.0

func _ready() -> void:
	player.position = player_start_position.position
	
func _process(delta):
	if(Input.is_action_pressed("shoot") and shoot_cooldown.is_stopped()):
		shoot()
	
	
func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = player.position + projectile_start_point.position
	
	var velosity = Vector2(0.0, -projectile_speed)
	projectile.linear_velocity = velosity
	
	add_child(projectile)
	shoot_cooldown.start()
	
