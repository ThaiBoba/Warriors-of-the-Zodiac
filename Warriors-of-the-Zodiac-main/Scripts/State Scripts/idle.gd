class_name PlayerIdleState
extends PlayerState

func enter() -> void:
	player.animation.play(idle_animation)

func exit(new_state: State = null) -> void:
	super(new_state)

func process_input(event: InputEvent) -> State:
	super(event)
	if event.is_action_pressed(movement_key): 
		determine_sprite_flipped(event.as_text())
		return walk_state
	elif event.is_action_pressed(jump_key): return jump_state
	elif event.is_action_pressed(attack1_key): return attack1_state
	elif event.is_action_pressed(attack2_key): return attack2_state
	return null
