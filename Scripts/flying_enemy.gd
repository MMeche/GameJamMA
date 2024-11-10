extends CharacterBody2D

const speed = 30
var direction: Vector2
var rng = RandomNumberGenerator.new()
var player: CharacterBody2D
var damage_amount = 2

func move(delta):
	velocity += direction * speed * delta
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	move(delta) 

func _on_timer_timeout() -> void:
	$Timer.wait_time = rng.randf_range(0.3, 1)
	direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		
func choose(array):
	array.shuffle()
	return array.front()

func _get_damage_amount() -> int:
	return damage_amount
