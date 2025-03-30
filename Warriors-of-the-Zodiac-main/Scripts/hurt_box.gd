class_name HurtBox
extends Area2D

@onready var camera: Camera = get_tree().get_first_node_in_group("Camera")

func _ready():
	collision_layer = 0 
	collision_mask = 2
	self.area_entered.connect(on_area_entered)
	
func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null: return
	add_game_juice()
	print("Damage Dealt")
	
func add_game_juice() -> void:
	camera.set_zoom_str(1.015)
	camera.set_shake_str(Vector2(8, 8))
