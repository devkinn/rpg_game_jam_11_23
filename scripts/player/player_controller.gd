extends CharacterBody2D

@export var speed: float = 300.0
@export var friction: float = 7.0
@export var acceleration: float = 10.0
@onready var single_fire = [$ProjectileStartPoint]
@onready var double_fire = [$DoubleStartPoint1,$DoubleStartPoint2]
@onready var triple_fire = [$DoubleStartPoint1,$ProjectileStartPoint,$DoubleStartPoint2]
@onready var shooting_mode = [single_fire, double_fire, triple_fire]
@onready var shoot_cooldown: Timer = $ShootCooldown
@export var projectile_scene: PackedScene
@export var projectile_speed = 500.0


var mode = 0
var direction: Vector2
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)

	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	
func _unhandled_input(event):
	if(event.is_action("shoot") and shoot_cooldown.is_stopped()):
		shoot()
	if(event.is_action_pressed("upgrade")):
		mode = (mode+1)%shooting_mode.size()
	if(event.is_action_pressed("attack_speed_up")):
		shoot_cooldown.wait_time /= 2
	if(event.is_action_pressed("attack_speed_down")):
		shoot_cooldown.wait_time *= 2
	
func shoot():
	for x in shooting_mode[mode]:
		var projectile = projectile_scene.instantiate()
		projectile.position = x.position
		
		var velosity = Vector2(0.0, -projectile_speed)
		projectile.linear_velocity = velosity
		
		add_child(projectile)
	shoot_cooldown.start()
	
