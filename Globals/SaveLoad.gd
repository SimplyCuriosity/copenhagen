extends Node
const save_location = "user://SafeFile.json"
var test_dictionary: Dictionary = {
	"first_var" = 0,
	"second_var" = null
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_game()
	print(test_dictionary)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Left Click"):
		test_dictionary.first_var += 1 
	if Input.is_action_just_pressed("interact"):
		_save_game()
	pass

func _save_game():
	var file = FileAccess.open(save_location,FileAccess.WRITE)
	file.store_var(test_dictionary.duplicate())
	file.close()
	pass

func _load_game():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location,FileAccess.READ)
		var save_data = file.get_var()
		test_dictionary = save_data.duplicate()
	pass
