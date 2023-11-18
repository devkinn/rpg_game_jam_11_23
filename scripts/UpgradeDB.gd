extends Node


const ITEM_ICON_PATH = "res://assets/upgrade_icons/items/"
const ABILITY_ICON_PATH = "res://assets/upgrade_icons/ability/"
const WEAPON_ICON_PATH = "res://assets/upgrade_icons/weapons/"

const ITEM_SCRIPT_PATH = "res://scripts/player/items/"
const ABILITY_SCRIPT_PATH = "res://scripts/player/abilities/"
const WEAPON_SCRIPT_PATH = "res://scripts/player/weapons/"

const UPGRADES = {
	"triple_shot": {
		"icon": ITEM_ICON_PATH + "damage_up.png",
		"displayname": "Triple Shot",
		"details": "Shoot 3 projectiles at once!",
		"type": "weapon",
		"script_path": WEAPON_SCRIPT_PATH + "triple_shot.gd"
	},
	"damage_up": {
		"icon": ITEM_ICON_PATH + "damage_up.png",
		"displayname": "Damage Up",
		"details": "Makes you hit harder",
		"type": "item",
		"script_path": null
	},
	"heal": {
		"icon": ITEM_ICON_PATH + "heal.png",
		"displayname": "Apple",
		"details": "Heals you for 20 hp",
		"type": "item",
		"script_path": null
	},
}
