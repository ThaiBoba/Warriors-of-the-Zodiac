extends Node

#@export var player_scene: PackedScene
#@export var enemy_scene: PackedScene

@onready var player: Player = $"Player"
#var enemy: Enemy

func _ready():
	print(player)
	#_spawn_characters()

func _spawn_characters():
	# Create Player
	player.character_name = GameState.character  # Load selected player
	get_tree().current_scene.add_child(player)
	player.global_position = Vector2(200, 300)

	# Create Enemy
	#enemy = enemy_scene.instantiate() as Enemy
	#enemy.enemy_name = GameState.enemy  # Load selected enemy
	#get_tree().current_scene.add_child(enemy)
	#enemy.global_position = Vector2(600, 300)

	# Link Enemy AI to Player
	#enemy.player = player
