extends AnimationTree


var state_machine 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = get("parameters/playback")
	state_machine.start("Start")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_machine.get_current_node() == "Player_Airborn" :
		set("parameters/conditions/jump",false)
	if state_machine.get_current_node() == "Player_Run":
		set("parameters/conditions/bumped",false)
	if state_machine.get_current_node() == "harfang_te_nique_ta_mere":
		set("parameters/conditions/firing",false)
	if state_machine.get_current_node() == "renard_spin" :
		set("parameters/conditions/spinning",false)
		


func _on_platform_player_is_running(x: float) -> void:
	set("parameters/conditions/running",true)
	set("parameters/conditions/iddle",false)

func _on_platform_player_is_jumping() -> void:
	set("parameters/conditions/jump",true)
	set("parameters/conditions/grounded",false)
	set("parameters/conditions/iddle",false)
	set("parametees/conditions/caribou",false)


func _on_platform_player_is_airborn() -> void:
	set("parameters/conditions/airborn",true)
	
	


func _on_platform_player_is_grounded() -> void:
	set("parameters/conditions/airborn",false)
	set("parameters/conditions/jump",false)
	set("parameters/conditions/flying",false)
	set("parameters/conditions/grounded",true)


func _on_platform_player_is_iddling() -> void:
	set("parameters/conditions/running",false)
	set("parameters/conditions/caribou",false)
	set("parameters/conditions/iddle",true)
	set("parameters/conditions/flying",false)
	


func _on_platformer_caribou_bumped() -> void:
	set("parameters/conditions/bumped",true)
	set("parameters/conditions/caribou",false)


func _on_platformer_caribou_is_charging() -> void:
	set("parameters/conditions/caribou",true)


func _on_platform_player_is_flying() -> void:
	set("parameters/conditions/flying",true)
	set("parameters/conditions/airborn",false)
	set("parameters/conditions/jump",false)
	
	


func _on_platform_player_is_firing() -> void:
	set("parameters/conditions/firing",true)


func _on_animation_player_changed() -> void:
	if state_machine.get_current_node() == "Player_Airborn" :
		set("parameters/conditions/jump",false)
	


func _on_platform_player_is_spinning() -> void:
	set("parameters/conditions/spinning",true)
