extends Node
const save_location_1 = "user://SafeFile_1.json"
const save_location_2 = "user://SafeFile_2.json"
const save_location_3 = "user://SafeFile_3.json"
var save_file_num: int = 0
var test_dictionary: Dictionary = {
	"first_var" : 0,
	"second_var" : null
}
var save_variables: Dictionary = {
	"last_current_level" : null,
	"current_cave" : null,
	"stage_open" : false,
	"stage_open_2" : false,
	"stage_open_3" : false,
	"stage_open_4" : false,
	"deni_speech_num" : 0,
	"deni_speech_max" : 1,
	"deni_dead_speech_num" : 0,
	"deni_dead_speech_max" : 9,
	"ag_intro_done" : false,
	"ag_speech_num" : 0,
	"ag_speech_max" : 1,
	"ag_dead_speech_num" : 0,
	"ag_dead_speech_max" : 9,
	"gai_speech_num" : 0,
	"gai_speech_max" : 1,
	"gai_dead_speech_num" : 0,
	"gai_dead_speech_max" : 9,
	"ress_speech_num" : 0,
	"ress_speech_max" : 1,
	"ress_dead_speech_num" : 0,
	"ress_dead_speech_max" : 9,
	"level_1_half_way": false,
	"level_2_half_way": false,
	"level_3_half_way": false,
	"level_4_half_way": false,
	#"respawn_bench" : null,
	"respawn_point" : null,
	"minigame_1_done": false,
	"minigame_2_done": false,
	"minigame_3_done": false,
	"minigame_4_done": false,
	"level_1_outro_done": false,
	"level_2_outro_done": false,
	"level_3_outro_done": false,
	"level_4_outro_done": false,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameManager.respawn_point)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Temporary Save"):
		_save_game(save_location_1)
		pass
	if Input.is_action_just_pressed("Temporary Delete Save"):
		_delete_save(save_location_1)
		pass
	if Input.is_action_just_pressed("Temporary Load Save"):
		_load_game(save_location_1)
		print(GameManager.respawn_point)
	pass

func _save_game(save_location):
	for i in save_variables:
		save_variables.set(i, GameManager.get(i))  
	
	var file = FileAccess.open(save_location,FileAccess.WRITE)
	file.store_var(save_variables.duplicate())
	file.close()
	pass
func _load_game(save_location):
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location,FileAccess.READ)
		var save_data = file.get_var()
		save_variables = save_data.duplicate()
		for i in save_variables:
			GameManager.set(i, save_variables.get(i))
	else:
		print("File do not exist")
	pass
	
func _delete_save(save_location):
	DirAccess.remove_absolute(save_location)
	pass
