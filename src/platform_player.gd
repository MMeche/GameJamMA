extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var speed = 300.0
var jump_speed = -400.0

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction_left = Input.is_action_pressed("move_left")
	var direction_right = Input.is_action_pressed("move_right")
	velocity.x = (int(direction_left)*-1 +int(direction_right)*1) * speed

	move_and_slide()

func _process(delta: float) -> void:
		# Detection interaction
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0 and Input.is_action_just_pressed("Actionable"):
			# TODO afficher le bouton entrer sur l'écran ?
			actionables[0].action()
