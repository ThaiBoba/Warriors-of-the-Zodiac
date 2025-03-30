extends Control

var current_character: String = ""
var current_enemy: String = ""
var game_manager: Node


func _ready():
	# Connect selection signals from all CharacterSlot children
	for slot in $VBoxContainer.get_children():
		if slot.has_signal("selected"):
			slot.selected.connect(_on_character_selected)
	
func _on_character_selected(name: String, stage_of_cycle:int):
	if stage_of_cycle == 1:
		current_enemy = name
		print("Enemy selected: %s" % name)
	elif stage_of_cycle == 0:
		current_character = name
		print("Character selected: %s" % name)
	else:
		if current_character == name:
			current_character = ""
		if current_enemy == name:
			current_enemy = ""

func _on_start_pressed():
	if current_character == "" or current_enemy == "":
		print("Please select both a character and an enemy.")
		return
	else:
		GameState.character = current_character
		GameState.enemy = current_enemy
		print("Starting game with Player: %s, Enemy: %s" % [GameState.character, GameState.enemy])
		get_tree().change_scene_to_file("res://Scenes/level.tscn")  # Load game scene
