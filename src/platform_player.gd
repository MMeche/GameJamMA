extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var speed_base = 55.0
var speed_spin = 110.0
var speed
var jump_speed = -130.0

var healt_amount = PlayerStats.player_health
var damage_amount = PlayerStats.player_damage
var available_forms = PlayerStats.player_forms
var money_amount = PlayerStats.player_money

var caribou = false
var harfang = false
var renard = false

signal is_running(x:float)
signal is_jumping
signal is_airborn
signal is_grounded
signal is_iddling
signal bumped
signal is_charging
signal is_flying
signal is_firing
signal is_spinning

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	speed = speed_base
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !$AnimationTree.get("parameters/conditions/caribou"):
		velocity.y = jump_speed
		is_jumping.emit()
	# Handle Flying
	if Input.is_action_pressed("jump") and $AnimationTree.get("parameters/playback").get_current_node() == "Player_Jump" and PlayerStats.harfang :
		is_flying.emit()   
	
	# Handle the fox double jump
	if Input.is_action_just_pressed("jump") and !is_on_floor() and $AnimationTree.get("parameters/playback").get_current_node() != "renard_jump" and PlayerStats.renard :
		velocity.y += 1.5*jump_speed
		is_jumping.emit()
	
	# Handle the spin attack move
	if Input.is_action_just_pressed("SpinAttack") and PlayerStats.renard :
		is_spinning.emit()
	if $AnimationTree.get("parameters/playback").get_current_node() == "renard_spin" :
		speed = speed_spin
		
	# Handle the Flying State
	if $AnimationTree.get("parameters/playback").get_current_node() == "harfang_fly" or $AnimationTree.get("parameters/playback").get_current_node() == "harfang_te_nique_ta_mere":
		if Input.is_action_pressed("Fire") :
			is_firing.emit()	
	# Add gravity
		velocity.y += gravity/10 * delta
	else :
		velocity.y += gravity/2 * delta


	# Get the input direction.
	var direction_left = Input.is_action_pressed("move_left")
	var direction_right = Input.is_action_pressed("move_right")
	if Input.is_action_pressed("Charge") && (direction_left||direction_right != false) and PlayerStats.caribou:
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
	if actionables.size() > 0 :
		$InterractableToggle.visible = true
		if Input.is_action_just_pressed("Actionable"):
			actionables[0].action()
			if(actionables[0].has_method("_get_evolve")):
				match actionables[0]._get_evolve():
					"caribou":
						_on_caribou_evolving()
					"harfang":
						_on_harfang_evolving()
					"renard":
						_on_renard_evolving()
	else:
		$InterractableToggle.visible = false

func _on_caribou_evolving() -> void :
	PlayerStats.caribou = true

func _on_harfang_evolving() -> void :
	PlayerStats.harfang = true

func _on_renard_evolving() -> void :
	PlayerStats.renard = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Hitbox":
		if area.get_parent().has_method("_get_damage_amount"):
			var node = area.get_parent() as Node
			healt_amount -= node.damage_amount
			print("Health amount = ", healt_amount) # TODO test
		
		if area.get_parent().has_method("_get_money_value"):
			var node = area.get_parent() as Node
			money_amount += node.money_value
			PlayerStats.player_money = money_amount;
			area.get_parent().queue_free()
			print("Money amount = ", money_amount)  # TODO test
			
	if healt_amount <= 0:
		get_tree().change_scene_to_file("res://scene/Gameover.tscn")
		
