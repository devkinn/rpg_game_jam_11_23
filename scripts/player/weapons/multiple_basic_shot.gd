extends Node

@onready var shot_cooldown: Timer = $"../ShotCooldown"
@onready var projectile_start_point: Marker2D = $"../ProjectileStartPoint"
@onready var player: CharacterBody2D = $".."
@onready var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")
@onready var main: Node = $"../.."

var projectile_speed: float = 500.0
var velocity = Vector2(0.0, -projectile_speed)

func shoot(n):
	var projectile
	
	if n==1:
		projectile = prepare()
		main.add_child(projectile)
	elif n==2:
		projectile = prepare()
		projectile.position += Vector2(-5,0)
		main.add_child(projectile)
		projectile = prepare()
		projectile.position += Vector2( 10,0)
		main.add_child(projectile)		
	else:
		var projectiles: int = 0
		var start_rotation: float = -PI / 6
		var between_rotation: float = (-start_rotation)*2/(n-1)
		
		while projectiles < n:

			projectile = prepare()
			projectile.rotation = start_rotation
			projectile.linear_velocity = velocity.rotated(start_rotation)
			main.add_child(projectile)
			
			start_rotation += between_rotation
			projectiles += 1
	
	shot_cooldown.start()

func prepare():
	var projectile: RigidBody2D = projectile_scene.instantiate()
	projectile.position = player.position + projectile_start_point.position
	projectile.linear_velocity = velocity
	return projectile
	
