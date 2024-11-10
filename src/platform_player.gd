extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var speed = 55.0
var jump_speed = -80.0

signal is_running(x:float)
signal is_jumping
signal is_airborn
signal is_grounded
signal is_iddling
signal bumped
signal is_charging
signal is_flying
signal is_firing

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !$AnimationTree.get("parameters/conditions/caribou"):
		velocity.y = jump_speed
		is_jumping.emit()
	# Handle Flying
	if Input.is_action_pressed("jump") and $AnimationTree.get("parameters/playback").get_current_node() == "Player_Jump" :
		is_flying.emit()   
		 
	# Handle the Flying State
	if $AnimationTree.get("parameters/playback").get_current_node() == "harfang_fly" or $AnimationTree.get("parameters/playback").get_current_node() == "harfang_te_nique_ta_mere":
		if Input.is_action_pressed("Fire") :
			is_firing.emit()
			
	# Add gravity
		velocity.y += gravity/8 * delta
	else :
		velocity.y += gravity/2 * delta


	# Get the input direction.
	var direction_left = Input.is_action_pressed("move_left")
	var direction_right = Input.is_action_pressed("move_right")
	if Input.is_action_pressed("Charge") && (direction_left||direction_right != false):
		is_charging.emit()
		
	velocity.x = (int(direction_left)*-1 +int(direction_right)*1) * speed
	move_and_slide()
	
	# emit signals for the animation node tree
	if abs(velocity.x) > 0 && is_on_floor():
		is_running.emit(velocity.x)
	if !is_on_floor():
		is_airborn.emit()
	else :
		is_grounded.emit()
	if velocity.x == 0 && is_on_floor():
		is_iddling.emit()
	if is_on_wall() :
		bumped.emit()
		
	
	#manage the Flip of the sprite
	if velocity.x < 0 :
		$Sprite2D.flip_h = true
	if velocity.x > 0 :
		$Sprite2D.flip_h = false
	
	
	

func _process(delta: float) -> void:
		# Detection interaction
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0 and Input.is_action_just_pressed("Actionable"):
			# TODO afficher le bouton entrer sur l'écran ?
			actionables[0].action()
		
