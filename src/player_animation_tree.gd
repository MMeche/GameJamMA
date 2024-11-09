extends AnimationTree


var state_machine 
var running = false
var iddle = true
var jump = false
var airborn = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = get("parameters/playback")
	state_machine.start("Start")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_machine.get_current_node() == "Player_Airborn" :
		jump = false


func _on_platform_player_is_running(x: float) -> void:
	running = true
	iddle = false

func _on_platform_player_is_jumping() -> void:
	jump = true
	iddle = false


func _on_platform_player_is_airborn() -> void:
	airborn = true


func _on_platform_player_is_grounded() -> void:
	airborn = false
