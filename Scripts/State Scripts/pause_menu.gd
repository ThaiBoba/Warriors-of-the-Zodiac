extends Control

@onready var optionsMenu = preload("res://Scenes/settings.tscn")

func _ready():
	$AnimationPlayer.play("RESET")
	set_process_unhandled_input(true)  # Ensure input works even when hidden
	hide()  # Start hidden

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()  # Hide pause menu but allow input again
	print("Game Resumed")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()  # Show pause menu
	print("Game Paused")

func _unhandled_input(event):
	if event.is_action_pressed("exit_scene"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	resume()  # Ensure the game is unpaused
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

func _on_quit_pressed() -> void:
	resume()  # Ensure the game is unpaused
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
