extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var speed = 300.0
var jump_speed = -400.0
var healt_amount = 20

signal is_running(x:float)
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

func _process(delta: float) -> void:
		# Detection interaction
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0 and Input.is_action_just_pressed("Actionable"):
			# TODO afficher le bouton entrer sur l'écran ?
			actionables[0].action()
		if abs(velocity.x) > 0 && is_on_floor():
			is_running.emit(velocity.x)
		if !is_on_floor():
			is_airborn.emit()
		else :
			is_grounded.emit()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Hitbox":
		if area.get_parent().has_method("_get_damage_amount"):
			var node = area.get_parent() as Node
			healt_amount -= node.damage_amount
			print("Health amount = ", healt_amount)
			
	if healt_amount <= 0:
		get_tree().change_scene_to_file("res://scene/Gameover.tscn")
		
			
