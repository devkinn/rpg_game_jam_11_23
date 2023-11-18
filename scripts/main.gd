extends Node


@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	player.position = player_start_position.position
	

