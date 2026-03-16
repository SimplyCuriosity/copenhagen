extends Node3D

@onready var dim_background: Sprite2D = $"CanvasLayer/Dim background"
@onready var canvas_modulate: CanvasModulate = $CanvasLayer/CanvasModulate 
@onready var pause_overlay: Node2D = $"CanvasLayer/Pause Overlay"



var playable_character
var third_person_cam 
var game_is_paused: bool = false
var Background_music
var setting_menu
var Resume_button_pressed:= false
var main_menu
var dialogue_system
var current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (game_is_paused and Input.is_action_just_pressed("Pause")) or Resume_button_pressed:
		game_is_paused = false
		get_tree().paused = false
		pause_overlay.visible = false
		if get_tree().current_scene != null:
			if get_tree().current_scene.name != "MainMenu":
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		dim_background.visible = false
		Resume_button_pressed = false
		setting_menu.visible = false
	elif not game_is_paused and Input.is_action_just_pressed("Pause") and get_tree().current_scene.name != "MainMenu":
		game_is_paused = true
		get_tree().paused = true
		pause_overlay.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		dim_background.visible = true
		
	pass
