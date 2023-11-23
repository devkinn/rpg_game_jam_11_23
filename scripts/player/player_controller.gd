extends CharacterBody2D



@export var Health: int = 3
signal game_over
@onready var immune: Timer = $Immunity
@onready var blink_switch: Timer = $Blink
# MOVEMENT
@export var speed: float = 300.0
@export var friction: float = 7.0
@export var acceleration: float = 10.0

var direction: Vector2
var screen_size: Vector2

# SHOOTING
@onready var shoot_node: Node = $Shoot
@onready var shot_cooldown: Timer = $ShotCooldown
@onready var basic_shot: Node = $Basic_shot
@onready var projectile: RigidBody2D = preload("res://scenes/projectile.tscn").instantiate()
var damage: float = 10
var shot_number: int = 1


# ABILITIES
@onready var ability_1_node: Node = $Ability1

# UPGRADES
@onready var progression_system: Node = $ProgressionSystem
@onready var upgrade_screen_ui = get_tree().get_first_node_in_group("upgrade_panel")

@export var max_upgrade_options: int = 3
@export var upgrade_option: PackedScene




var collected_upgrades = []
var upgrade_options = []

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	
func _process(delta: float) -> void:
	if(Input.is_action_pressed("shoot") and shot_cooldown.is_stopped()):
		get_parent().get_node("Sounds/Shoot").play()
		basic_shot.shoot(shot_number, projectile)
	if(!immune.is_stopped()):
		if(blink_switch.is_stopped()):
			visible = !visible
			blink_switch.start()
	else:
		visible = true


func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)

	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	if(get_slide_collision_count()>0 and immune.is_stopped()):
		hit()
	
	
  
func upgrade_player(upgrade) -> void:

	get_parent().get_node("User_Interface").external_pause = false
	if UpgradeDb.UPGRADES[upgrade]["type"] == "weapon":
		projectile.set_script(load(UpgradeDb.UPGRADES[upgrade]["script_path"]))
	elif UpgradeDb.UPGRADES[upgrade]["type"] == "ability":
		ability_1_node.queue_free()
		ability_1_node = Node.new()
		ability_1_node.set_script(load(UpgradeDb.UPGRADES[upgrade]["script_path"]))
	elif upgrade == "shot_up":
		shot_number+=1
	elif upgrade == "heal":
		Health+=1
	elif upgrade == "damage_up":
		damage += 5
	if UpgradeDb.UPGRADES[upgrade]["type"] != "item":
		collected_upgrades.append(upgrade)
	upgrade_options.clear()
	for child in upgrade_screen_ui.get_child(0).get_children():
		child.queue_free()
	upgrade_screen_ui.visible = false
	
func get_random_item():
	var item_list = []
	for item in UpgradeDb.UPGRADES:
		if item in collected_upgrades:
			pass
		elif item in upgrade_options:
			pass
		else:
			item_list.append(item)
	if item_list.size() > 0:
		var random_item = item_list.pick_random()
		if UpgradeDb.UPGRADES[random_item]["type"] != "repeatable":
			upgrade_options.append(random_item)
		return random_item
	else:
		return null
	
func level_up():
	upgrade_screen_ui.visible = true
	var options = 0
	while options < max_upgrade_options:
		var option_choice = upgrade_option.instantiate()
		option_choice.item = get_random_item()
		upgrade_screen_ui.get_child(0).add_child(option_choice)
		options += 1
	get_tree().paused = true
	get_parent().get_node("User_Interface").external_pause = true
	
func _on_button_pressed() -> void:
	progression_system.add_xp(randi_range(3, 5))

func hit():
	immune.start()
	Health -=1
	if Health==0:
		game_over.emit()
	


