extends CharacterBody2D

@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var sounds: Node = get_parent().get_node("Sounds/Ghost")


const speed = 300.0
const BaseHealth = 25
var health = 30.0


func _ready():
	velocity = Vector2(0, speed)
	$AnimatedSprite2D.play()

func _physics_process(delta):
	if(move_and_collide(velocity*delta)):
		health -= player.damage
		if(health<0):
			sounds.get_node("Death").play()
			player.get_node("ProgressionSystem").add_xp(5)
			queue_free()

func add_health(hp: int):
	health += hp
