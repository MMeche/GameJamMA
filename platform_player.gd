extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0

signal is_running(x :float)
signal is_jumping
signal is_airborn
signal is_grounded

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		is_jumping.emit()

	# Get the input direction.
	var direction_left = Input.is_action_pressed("move_left")
	var direction_right = Input.is_action_pressed("move_right")
	velocity.x = (int(direction_left)*-1 +int(direction_right)*1) * speed

	move_and_slide()
	
func _process(delta):
	if abs(velocity.x) > 0 && is_on_floor():
		is_running.emit(velocity.x)
	if !is_on_floor():
		is_airborn.emit()
	else :
		is_grounded.emit()
