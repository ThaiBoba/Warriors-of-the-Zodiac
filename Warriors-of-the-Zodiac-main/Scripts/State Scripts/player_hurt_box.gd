class_name PlayerHurtBox
extends HurtBox
	
@onready var pain_state: PlayerPainState = $".."
@onready var state_machine: StateMachine = $"../.."
	
func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null: return
	super(hit_box)
	state_machine.change_state(pain_state)
	
