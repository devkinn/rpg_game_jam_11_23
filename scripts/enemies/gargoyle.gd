extends CharacterBody2D

@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var sounds: Node = get_parent().get_node("Sounds/Gargoyle")


const speed = 200.0
const BaseHealth = 80.0
@export var health = 80.0


func _ready():
	velocity = Vector2(0, speed)
	$AnimatedSprite2D.play()

func _physics_process(delta):
	
	if(move_and_collide(velocity*delta)):
		health -= player.damage
		if(health<0):
			sounds.get_node("Death").play()
			player.get_node("ProgressionSystem").add_xp(10)
			queue_free()
			
func add_health(hp: int):
	health += hp
