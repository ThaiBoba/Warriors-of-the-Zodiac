extends Control
var current_character : String
var current_enemy : String


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	
