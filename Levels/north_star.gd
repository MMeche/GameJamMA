extends Area2D

@export var ui_night_timer : Control
@export var ui_end : Control
@export var ui_coin_life : Control

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	ui_end.visible = false

func _on_body_entered(body):
	ui_end.visible = true
	ui_coin_life.visible = false
	ui_night_timer.visible = false
	# Arrêter le timer ici
	queue_free()
