extends CharacterBody2D

@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var sounds: Node = get_parent().get_node("Sounds/Gargoyle")


const speed = 200.0
var health = 80.0


func _ready():
	velocity = Vector2(0, speed)
	$AnimatedSprite2D.play()

func _physics_process(delta):
	
	if(move_and_collide(velocity*delta)):
		health -= player.damage
		if(health<0):
			#sounds.get_node("Death").play()
			player.get_node("ProgressionSystem").add_xp(5)
			queue_free()
