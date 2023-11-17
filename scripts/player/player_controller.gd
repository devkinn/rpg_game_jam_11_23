extends CharacterBody2D

signal level_up

@onready var progression_system: Node = $ProgressionSystem

@export var speed: float = 300.0
@export var friction: float = 7.0
@export var acceleration: float = 10.0

var direction: Vector2
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)

	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
		

func _on_button_pressed() -> void:
	progression_system.add_xp(randi_range(3, 5))
	
func level_gained():
	level_up.emit()
