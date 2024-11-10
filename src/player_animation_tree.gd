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
		


func _on_platform_player_is_running(x: float) -> void:
	set("parameters/conditions/running",true)
	set("parameters/conditions/iddle",false)

func _on_platform_player_is_jumping() -> void:
	set("parameters/conditions/jump",true)
	set("parameters/conditions/iddle",false)


func _on_platform_player_is_airborn() -> void:
	set("parameters/conditions/airborn",true)


func _on_platform_player_is_grounded() -> void:
	set("parameters/conditions/airborn",false)
	set("parameters/conditions/grounded",true)


func _on_platform_player_is_iddling() -> void:
	set("parameters/conditions/running",false)
	set("parameters/conditions/iddle",true)
	
