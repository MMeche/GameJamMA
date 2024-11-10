extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null
var damage_amount = 4

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if player_chase:
		velocity = Vector2(player.position.x - position.x, 0).normalized() * speed
	velocity.y += gravity * delta * speed
	move_and_slide()

func _on_detection_arena_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_arena_body_exited(body: Node2D) -> void:
	player_chase = false

func _get_damage_amount() -> int:
	return damage_amount
	velocity = Vector2(0, 0)
