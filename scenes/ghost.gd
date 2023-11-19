extends CharacterBody2D

var max_health: int = 20
var current_health: int = max_health
var speed: float = 50
var enemy_scene = preload("res://scenes/ghost.tscn")

func _ready():
	position = Vector2(randf_range(0, get_viewport_rect().size.x), -100)
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y or current_health <= 0:
		queue_free()



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.current_health -= 10
	if body.is_in_group("Projectile"):
		take_damage()
	
	
func take_damage():
	current_health -= 10
	if current_health <= 0:
		queue_free()
		
func spawn_ghost() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(randf_range(0, get_viewport_rect().size.x), -100)
	add_child(enemy)
	await get_tree().create_timer(7).timeout
	spawn_ghost()
	
func _on_timer_timeout():
	spawn_ghost() 
   
	
	
	
