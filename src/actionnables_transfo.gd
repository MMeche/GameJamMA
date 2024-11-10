extends Area2D


@export var dialogue_ressource: DialogueResource
@export var dialogue_start: String = "start"
@export var evolve : String 

signal evolving_caribou
signal evolving_harfang
signal evolving_renard

func action() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_ressource, dialogue_start)
	match evolve :
		"caribou":
			evolving_caribou.emit()
		"harfang":
			evolving_harfang.emit()
		"renard":
			evolving_renard.emit()
		_ :
			pass