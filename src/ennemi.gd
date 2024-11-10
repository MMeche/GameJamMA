extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null
var damage_amount = 4

func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position) / speed

func _on_detection_arena_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_arena_body_exited(body: Node2D) -> void:
	player_chase = false

func _get_damage_amount() -> int:
	return damage_amount
