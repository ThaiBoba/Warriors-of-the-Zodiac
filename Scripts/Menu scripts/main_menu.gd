extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.volume_db = -50.0


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_settings_pressed() -> void:
	await get_tree().process_frame  # Ensures everything is processed
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
