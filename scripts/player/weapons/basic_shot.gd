extends Node


@onready var shot_cooldown: Timer = $"../ShotCooldown"
@onready var projectile_start_point: Marker2D = $"../ProjectileStartPoint"
@onready var player: CharacterBody2D = $".."


@export var projectile_scene: PackedScene
@export var projectile_speed: float = 500.0

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = player.position + projectile_start_point.position
	
	var velocity = Vector2(0.0, -projectile_speed)
	projectile.linear_velocity = velocity
	
	add_child(projectile)
	shot_cooldown.start()
