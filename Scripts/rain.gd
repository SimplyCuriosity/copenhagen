extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.playable_character != null:
		global_position.x = GameManager.playable_character.global_position.x
		global_position.y = GameManager.playable_character.global_position.y - 1080
	pass
