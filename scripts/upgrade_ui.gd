extends Button

signal upgrade_selected(upgrade)

@onready var upgrade_name: Label = $Name
@onready var upgrade_description: Label = $Description
@onready var texture_rect: TextureRect = $TextureRect


var item = null
@onready var player = get_tree().get_first_node_in_group("player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("upgrade_selected", Callable(player, "upgrade_player"))
	if item == null:
		item = "heal"
	upgrade_name.text = UpgradeDb.UPGRADES[item]["displayname"]
	upgrade_description.text = UpgradeDb.UPGRADES[item]["details"]
	texture_rect.texture = load(UpgradeDb.UPGRADES[item]["icon"])

func _on_pressed() -> void:
	emit_signal("upgrade_selected", item)
	get_tree().paused = false
