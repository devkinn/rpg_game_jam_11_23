extends CanvasLayer

signal start_game

@export var external_pause: bool = false
var e
var ustawienia_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	e = "nothing"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if e != "nothing":
		if event is InputEventKey and event.pressed:
			var x = event
			InputMap.action_erase_events(e)
			InputMap.action_add_event(e,x)
			if e == "move_up":
				$Ustawienia/Controls/up_bind.text = x.as_text()
			if e == "move_down":
				$Ustawienia/Controls/down_bind.text = x.as_text()
			if e == "move_left":
				$Ustawienia/Controls/left_bind.text = x.as_text()
			if e == "move_right":
				$Ustawienia/Controls/right_bind.text = x.as_text()
			if e == "shoot":
				$Ustawienia/Controls/shoot_bind.text = x.as_text()
			if e == "upgrade":
				$Ustawienia/Controls/upgrade_bind.text = x.as_text()
			if e == "attack_speed_up":
				$Ustawienia/Controls/attackspeedup_bind.text = x.as_text()
			if e == "attack_speed_down":
				$Ustawienia/Controls/attackspeeddown_bind.text = x.as_text()
			e = "nothing"
			$Ustawienia/Controls/zmien_klawisz.hide()

func _on_controls_button_pressed():
	$Ustawienia/settings.hide()
	$Ustawienia/Controls.show()


func _on_settings_button_pressed():
	$Ustawienia/settings.show()
	$Ustawienia/Controls.hide()

func _on_edit_button_1_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for move up action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="move_up"


func _on_edit_button_2_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for move down action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="move_down"

func _on_edit_button_3_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for move left action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="move_left"


func _on_edit_button_4_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for move right action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="move_right"


func _on_edit_button_5_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for shoot action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="shoot"


func _on_edit_button_6_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for upgrade action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="upgrade"


func _on_edit_button_7_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for attack speed up action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="attack_speed_up"


func _on_edit_button_8_pressed():
	$Ustawienia/Controls/zmien_klawisz/Label2.text = "Press a new key for attack speed down action"
	$Ustawienia/Controls/zmien_klawisz.show()
	e="attack_speed_down"

var pausable = false
func _on_texture_button_pressed():
	pausable = not pausable
	if external_pause == false:
		get_tree().paused = not get_tree().paused
	if(pausable==true):
		$menu_pauzy.show()
		$pause_button.hide()
		$pause_button.texture_normal = ResourceLoader.load("res://assets/user_interface/play.svg")
		$pause_button.show()
	else:
		$menu_pauzy.hide()
		$pause_button.hide()
		$pause_button.texture_normal = ResourceLoader.load("res://assets/user_interface/pauza.svg")
		$pause_button.show()
		$Ustawienia.hide()
		
func _on_close_button_pressed():
	if get_tree().paused == true:
		$Ustawienia.hide()
		$menu_pauzy.show()
	else:
		$Ustawienia.hide()
		ustawienia_open=false
		


func _on_resume_button_pressed():
	if external_pause == false:
		get_tree().paused = false
	pausable = false
	$menu_pauzy.hide()
	$pause_button.hide()
	$pause_button.texture_normal = ResourceLoader.load("res://assets/user_interface/pauza.svg")
	$pause_button.show()


func _on_open_settings_button_pressed():
	$Ustawienia.show()
	$menu_pauzy.hide()


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),value)

func _on_start_button_pressed():
	$ustawienia_button.hide()
	$pause_button.show()
	$menu_start.hide()
	start_game.emit()

func _on_ustawienia_button_pressed():
	ustawienia_open = not ustawienia_open
	if ustawienia_open==true:
		$Ustawienia.show()
	else:
		$Ustawienia.hide()
	
func game_over():
	$menu_start.show()
	$menu_start/Title.hide()
	$menu_start/Title2.show()
	$menu_start/start_button.text = "PLAY AGAIN"
	$pause_button.hide()
	$ustawienia_button.show()

var postac = ["default","dragon","pegaz"]
var obrazek = ["res://assets/player/Alikorn.png","res://assets/player/Smok.png","res://assets/player/Pegaz.png"]
var i = 0
func _on_lewo_button_pressed():
	i=i-1
	if(i<0):
		i=2
	$Ustawienia/settings/character.texture = ResourceLoader.load(obrazek[i])
	get_parent().get_node("Player").get_node("AnimatedSprite2D").animation = postac[i]


func _on_prawo_button_pressed():
	i=i+1
	if(i>2):
		i=0
	$Ustawienia/settings/character.texture = ResourceLoader.load(obrazek[i])
	get_parent().get_node("Player").get_node("AnimatedSprite2D").animation = postac[i]
