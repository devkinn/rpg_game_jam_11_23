extends ParallaxBackground

@export var scrolling_speed = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_base_offset += Vector2(0,scrolling_speed)*delta
