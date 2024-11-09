extends CharacterBody2D

@export var speed = 400

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vel = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		vel.x += 1
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
	if Input.is_action_pressed("jump"):
		vel.y -= 1
	if Input.is_action_pressed("move_down"):
		vel.y += 1

	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	var collision = move_and_collide(vel * delta)
	if collision :
		vel = vel.slide(collision.get_normal())
	
	var actionables = actionable_finder.get_overlapping_areas()
	if actionables.size() > 0:
		actionables[0].action()
