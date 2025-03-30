extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	audio_player.volume_db = -50.0


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_scene"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0: DisplayServer.window_set_size(Vector2i(1920,1080))
		1: DisplayServer.window_set_size(Vector2i(1600,9000))
		2: DisplayServer.window_set_size(Vector2i(1280,720))


func _on_backmainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
