extends Node3D
@onready var pause_overlay: Node2D = $"Pause Overlay"


var playable_character
var third_person_cam 
var game_is_paused: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_is_paused and Input.is_action_just_pressed("Pause"):
		game_is_paused = false
		get_tree().paused = false
		pause_overlay.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif not game_is_paused and Input.is_action_just_pressed("Pause"):
		game_is_paused = true
		get_tree().paused = true
		pause_overlay.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass
