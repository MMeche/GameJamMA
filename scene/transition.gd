extends Control

@export var day_window: MarginContainer
@export var night_window: MarginContainer
@export var day_text: Label
@export var night_text: Label
@export var count_day_text: Label
@export var count_night_text: Label

@export var left_position: Vector2
@export var right_position: Vector2
@export var center_position: Vector2
@export var transition_duration: float = 0.5

var is_day: bool = true # À rendre global

var wait_timer: Timer

func _ready() -> void:
	wait_timer = Timer.new()
	wait_timer.wait_time = 5.0 
	wait_timer.one_shot = true
	add_child(wait_timer)
	if is_day:
		day_to_night()
	else:
		night_to_day()

func night_to_day() -> void:
	night_text.text = "Le soleil se lève,\nrentrons au village."
	day_text.text = "Profitons de la journée \npour se préparer à explorer !"
	night_window.position = center_position
	day_window.position = right_position
	
	wait_timer.start()
	await wait_timer.timeout
	
	move_window(night_window, left_position)
	move_window(day_window, center_position)
	
	is_day = true
	
	wait_timer.start()
	await wait_timer.timeout

func day_to_night() -> void:
	day_text.text = "Profitons de la journée \npour se préparer à explorer !"
	night_text.text = "Le soleil se couche,\npréparons-nous pour la nuit."
	day_window.position = center_position
	night_window.position = right_position

	wait_timer.start()
	await wait_timer.timeout

	move_window(day_window, left_position)
	move_window(night_window, center_position)
	
	is_day = false
	
	wait_timer.start()
	await wait_timer.timeout

func move_window(window: MarginContainer, target_position: Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(window, "position", target_position, transition_duration)
