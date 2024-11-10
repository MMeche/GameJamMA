extends Node2D

@export var next_stage1: String
@export var next_stage2: String
@export var next_stage3: String
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(PlayerStats.player_health==0):
		_player_death()
	var exits1 = $nextStageZone.get_overlapping_areas()
	var exits2 = $nextStageZone2.get_overlapping_areas()
	var exits3 = $nextStageZone3.get_overlapping_areas()
	
	if exits1.size() >0  and exits1[0] == $platformer_caribou/Direction/ActionableFinder:
		_load_next_scene(next_stage1)
	
	if exits2.size() >0  and exits2[0] == $platformer_caribou/Direction/ActionableFinder:
		_load_next_scene(next_stage2)
		
	if exits3.size() >0  and exits3[0] == $platformer_caribou/Direction/ActionableFinder:
		_load_next_scene(next_stage3)

func _load_next_scene(next_stage) -> void:
	get_tree().change_scene_to_file(next_stage)
	
func _player_death() -> void:
	PlayerStats.nb_Days += 1
	get_tree().change_scene_to_file("res://Levels/level0.tscn")
