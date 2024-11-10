extends CharacterBody2D

const speed = 30
var direction: Vector2
var rng = RandomNumberGenerator.new()
var is_chasing: bool
var player = null
var damage_amount = 2

func move(delta):
	if !is_chasing:
		velocity += direction * speed * delta
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	if is_chasing:
		position += (player.position - position) / speed
	move(delta)

func _on_timer_timeout() -> void:
	$Timer.wait_time = rng.randf_range(1, 3)
	if !is_chasing:
		direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		
func choose(array):
	array.shuffle()
	return array.front()

func _get_damage_amount() -> int:
	return damage_amount

func _on_detection_zone_body_entered(body: Node2D) -> void:
	player = body
	is_chasing = true

func _on_detection_zone_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	is_chasing = false
