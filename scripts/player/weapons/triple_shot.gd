extends Node

@onready var shot_cooldown: Timer = $"../ShotCooldown"
@onready var projectile_start_point: Marker2D = $"../ProjectileStartPoint"
@onready var player: CharacterBody2D = $".."
@onready var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")

var projectile_speed: float = 500.0

func shoot():
	var projectiles: int = 0
	var start_rotation: float = -PI / 6
	
	while projectiles < 3:
		var projectile: RigidBody2D = projectile_scene.instantiate()
		projectile.position = player.position + projectile_start_point.position
		
		var velocity = Vector2(0.0, -projectile_speed)
		projectile.rotation = start_rotation
		projectile.linear_velocity = velocity.rotated(start_rotation)
		add_child(projectile)
		
		start_rotation += PI / 6
		projectiles += 1
	
	shot_cooldown.start()
