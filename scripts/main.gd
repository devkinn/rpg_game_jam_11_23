extends Node

@onready var player: CharacterBody2D = $Player
@onready var player_start_position: Marker2D = $PlayerStartPosition

func _ready() -> void:
	player.position = player_start_position.position
