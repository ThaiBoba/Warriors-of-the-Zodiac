class_name PlayerState
extends State

@onready var player: Player = get_tree().get_first_node_in_group("Kitsune") 
@onready var camera: Camera = get_tree().get_first_node_in_group("Camera") 

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", -9.8)

#Animation Names
var idle_animation: String = "Idle"
var walk_animation: String = "Walk"
var jump_animation: String = "Jump"
var fall_animation: String = "Fall"
var attack1_animation: String = "Attack1"
var attack2_animation: String = "Attack2"
var pain_animation: String = "Pain"


#states
@export_group("States")
@export var idle_state: PlayerState
@export var walk_state: PlayerState
@export var jump_state: PlayerState
@export var fall_state: PlayerState
@export var attack1_state: PlayerState
@export var attack2_state: PlayerState
@export var pain_state: PlayerState

#State variable
var sprite_flipped: bool = false

#input keys
var movement_key: String = "Movement"
var left_key: String = "Left"
var right_key: String = "Right"
var jump_key: String = "Jump"
var attack1_key: String = "Attack1"
var attack2_key: String = "Attack2"


#Input Action
var left_actions: Array = InputMap.action_get_events(left_key).map(func(action: InputEvent) -> String: 
	return action.as_text().get_slice(" (", 0))
var right_actions: Array = InputMap.action_get_events(right_key).map(func(action: InputEvent) -> String: 
	return action.as_text().get_slice(" (", 0))
	
#Util Func
func determine_sprite_flipped(event_text: String) ->  void:
	if left_actions.find(event_text) != -1: sprite_flipped = true
	elif right_actions.find(event_text) != -1: sprite_flipped = false
	player.sprite.flip_h = sprite_flipped

#Base Func
func process_physics(delta: float) -> State:
	if (player.velocity.y > 0): return fall_state
	player.velocity.y += gravity * delta
	player.move_and_slide()
	return null
	
func exit(new_state: State = null) -> void:
	super()
	new_state.sprite_flipped = sprite_flipped
