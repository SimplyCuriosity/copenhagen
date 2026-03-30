extends AudioStreamPlayer
var lowering:= false
var increasing:= false
var target_volume = 0
var music_cue

signal fade_out_over()
signal fade_in_over()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.Background_music = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lowering:
		if volume_db > -60:
			volume_db -= delta *40
		else:
			lowering = false
			fade_out_over.emit()
		
	
	elif increasing:
		if volume_db < target_volume:
			volume_db += delta *40
		else:
			increasing = false
			fade_in_over.emit()
	pass

func _change_music(music, volume):
	target_volume = volume
	lowering = true
	music_cue = music
	await fade_out_over
	stream = music_cue
	volume_db = volume
	playing = true
	#increasing = true
	pass
