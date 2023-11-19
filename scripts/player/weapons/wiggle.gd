extends RigidBody2D

@onready var timer = $Timer
var left = true;
func _ready():
	#rotation += PI/8
	linear_velocity = linear_velocity.rotated(PI/8)
	timer.start()

func _on_timer_timeout():
	timer.set_wait_time(timer.get_wait_time()*2)
	if left:
		#rotation -= PI/4
		linear_velocity = linear_velocity.rotated(-PI/4)
		left = false
	else:
		#rotation += PI/4
		linear_velocity = linear_velocity.rotated(PI/4)
		left=true
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


	
	

