extends Control

@export var coin_text : Label
@export var heart_text : Label

var coin_value : int = 255 # À rendre global
var heart_value : int = 3 # À rendre global

func _process(_delta: float) -> void:
	coin_text.text = str(coin_value)
	heart_text.text = str(heart_value)
