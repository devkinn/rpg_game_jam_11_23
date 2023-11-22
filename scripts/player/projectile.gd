extends RigidBody2D
@onready var hit: AudioStreamPlayer = $Hit



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	




	


func _on_body_entered(body):
	get_parent().get_node("Sounds/Hit").play()
	queue_free()


