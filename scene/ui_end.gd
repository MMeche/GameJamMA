extends Control

@export var days_end : Label
@export var timer_end : Label

var timer_value : int = 128 # À rendre global
var day_count: int = 1 # À rendre global

func _process(_delta: float) -> void:
	days_end.text = str("Jour :", day_count)
	timer_end.text = str("Timer :", timer_value)
