class_name Player
extends CharacterBody2D

@export var character_name: String = "Default"  # Set by password manager
@export var sprite_path: String = "res://Assets/Characters/"  # Base path for sprites

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var health_bar: ProgressBar = $HealthBar
@onready var state_machine: StateMachine = $"State Machine"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	print("Character Name: ", character_name)
	if animation == null:
		print("ERROR: AnimationPlayer is missing from Player scene!")
	if animated_sprite == null:
		print("ERROR: AnimatedSprite2D is missing from Player scene!")
	state_machine.init()
	_load_animations()

func _process(delta):
	state_machine.process_frame(delta)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _input(event):
	state_machine.process_input(event)

# Load animations dynamically, checking for prebuilt .tres files first
func _load_animations():
	var sprite_frames_path = sprite_path + character_name + "/" + character_name + "_SpriteFrames.tres"
	if ResourceLoader.exists(sprite_frames_path):
		animated_sprite.frames = load(sprite_frames_path)
		print("Loaded prebuilt SpriteFrames for", character_name)
	else:
		print("No prebuilt SpriteFrames found, generating dynamically...")
		_generate_animations()

func _generate_animations():
	var character_folder = sprite_path + character_name + "/"
	var dir = DirAccess.open(character_folder)
	if dir == null or dir.list_dir_begin() != OK:
		print("Error: Could not open directory ", character_folder)
		return

	animated_sprite.frames = SpriteFrames.new()

	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".png"):
			var animation_name = file_name.get_basename()
			var texture = load(character_folder + file_name) as Texture2D
			if texture:
				_add_frames_to_animation(texture, animation_name)
		file_name = dir.get_next()
	dir.list_dir_end()

func _add_frames_to_animation(texture: Texture2D, animation_name: String):
	var frame_width = 32
	var frame_height = 32
	var columns = texture.get_width() / frame_width
	var rows = texture.get_height() / frame_height

	if not animated_sprite.frames.has_animation(animation_name):
		animated_sprite.frames.add_animation(animation_name)

	for row in range(rows):
		for col in range(columns):
			var rect = Rect2(col * frame_width, row * frame_height, frame_width, frame_height)
			var frame_texture = AtlasTexture.new()
			frame_texture.atlas = texture
			frame_texture.region = rect
			animated_sprite.frames.add_frame(animation_name, frame_texture)

	animated_sprite.play(animation_name)
