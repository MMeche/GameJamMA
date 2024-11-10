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
var day_count: int = 1 # À rendre global
var next_scene_path: String = "res://scene/main_menu.tscn" # À rendre global

var wait_timer: Timer

@export var fade_duration: float = 3.0


var fade_rect: ColorRect

func _ready() -> void:
	# FADE
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 1)
	fade_rect.position = Vector2(0, 0)
	fade_rect.size = Vector2(2000, 2000)
	add_child(fade_rect)
	# fade_tween = create_tween() 
	fade_in()
	
	# MOVE TIMER
	wait_timer = Timer.new()
	wait_timer.wait_time = 5.0 
	wait_timer.one_shot = true
	add_child(wait_timer)
	
	# MOVE
	if GameManager.is_day:
		day_to_night()
	else:
		night_to_day()

func night_to_day() -> void:
	night_text.text = "Tu n'as pas trouvé \nl'Étoile du Nord."
	day_text.text = "Rentrons au village \navant de réessayer !"
	count_night_text.text = str("Nuit ", day_count)
	day_count = day_count + 1
	count_day_text.text = str("Jour ", day_count)
	night_window.position = center_position
	day_window.position = right_position
	
	wait_timer.start()
	await wait_timer.timeout
	
	move_window(night_window, left_position)
	move_window(day_window, center_position)
	
	is_day = true
	
	wait_timer.start()
	await wait_timer.timeout
	
	change_scene()

func day_to_night() -> void:
	day_text.text = "Le soleil se couche, \nallons sauver la fôret."
	night_text.text = "Vas-tu retrouver \nl'Étoile du Nord ?"
	count_day_text.text = str("Jour ", day_count)
	count_night_text.text = str("Nuit ", day_count)
	day_window.position = center_position
	night_window.position = right_position

	wait_timer.start()
	await wait_timer.timeout

	move_window(day_window, left_position)
	move_window(night_window, center_position)
	
	is_day = false
	
	wait_timer.start()
	await wait_timer.timeout
	
	change_scene()

func move_window(window: MarginContainer, target_position: Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(window, "position", target_position, transition_duration)


func fade_in() -> void:
	var fade_tween = create_tween()
	fade_rect.visible = true
	fade_rect.modulate.a = 1
	fade_tween.tween_property(fade_rect, "modulate:a", 0, fade_duration)

func change_scene() -> void:
	var fade_tween = create_tween()
	fade_rect.visible = true
	fade_rect.modulate.a = 0 
	fade_tween.tween_property(fade_rect, "modulate:a", 1, fade_duration)
	
	await fade_tween.finished
	_on_fade_out_complete()

func _on_fade_out_complete() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")
