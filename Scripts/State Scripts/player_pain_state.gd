class_name PlayerPainState
extends PlayerState

@onready var hurt_box: Area2D = $HurtBox

var has_pained: bool

func enter() -> void:
	print("Entered PlayerPainState")
	has_pained = false
	player.animation.play(pain_animation)
	player.animation.animation_finished.connect(func(_anim): 
		print("Pain animation finished") 
		has_pained = true)

func process_input(event: InputEvent) -> State:
	super(event)
	if has_pained and event.is_action_pressed(movement_key): 
		determine_sprite_flipped(event.as_text())
		return walk_state
	elif has_pained and event.is_action_pressed(jump_key): return jump_state
	return null

func process_frame(delta: float) -> State:
	if has_pained: return idle_state
	return super(delta)
	
func add_game_juice() -> void: 
	camera.set_zoom_str(1.015)
	camera.set_shake_str(Vector2(5, 5))
