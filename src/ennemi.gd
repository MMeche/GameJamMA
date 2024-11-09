extends RigidBody2D

var speed = 25 # TODO à changer ?
var player_chase = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position) / speed

func _on_detection_arena_body_entered(body: Node2D) -> void:
	player = body # TODO nécessaire ?
	player_chase = true

func _on_detection_arena_body_exited(body: Node2D) -> void:
	player_chase = false
