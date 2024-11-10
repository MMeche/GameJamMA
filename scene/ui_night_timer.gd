extends Control

@export var timer_text : Label

var timer_value : int = 128 # À rendre global

func _process(_delta: float) -> void:
	timer_text.text = str($Timer.time_left, "s")


func _on_timer_timeout() -> void:
	GameManager.is_day = true
