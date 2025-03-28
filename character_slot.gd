extends Panel

var icon : Texture = null  # Correcting the syntax for type hinting
var character_name : String
var stage_of_cycle = 0

# Setter to change the texture of the button
# Custom signal that will be emitted when the button is pressed
signal pressed

# Called when the panel is ready
func _ready() -> void:
	# Hides the CharacterSelect initially
	$CharacterSelect.hide()

	# Connect the button's pressed signal to our custom function
	$TextureButton.pressed.connect(_button_pressed)

# Function that is triggered when the button is pressed
func _button_pressed() -> void:
	if stage_of_cycle == 0:
		# Deselect all slots in the parent container
		for slot in get_parent().get_children():
			if slot is Panel and slot != self:  # Only deselect if it's a Panel
				slot.deselect_character()
				slot.stage_of_cycle = 0
		
		# Show the CharacterSelect element
		$CharacterSelect.show()
	elif stage_of_cycle == 1:
		# Deselect all slots in the parent container
		for slot in get_parent().get_children():
			if slot is Panel and slot != self:  # Only deselect if it's a Panel
				slot.deselect_enemy()
				slot.stage_of_cycle = 0
		
		# Show the CharacterSelect element
		$EnemySelect.show()
	else:
		deselect_enemy()
		deselect_character()
	stage_of_cycle = (stage_of_cycle + 1) % 3
	

	# Emit the custom 'pressed' signal
	pressed.emit()

# Function to hide the CharacterSelect element when deselected
func deselect_character() -> void:
	$CharacterSelect.hide()

func deselect_enemy() -> void:
	$EnemySelect.hide()
