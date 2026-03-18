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
#var current_scene
var deni_speech_num = 0
var deni_speech_max = 1
var deni_dead_speech_num = 0
var deni_dead_speech_max = 9
var just_died:= false
var level_1_half_way:= false:
	set(value):
		level_1_half_way = value
		if value == true:
			_update_alternate_neu_position()
			if get_tree().current_scene.name == "Level 1":
				deni_dead_speech_num = 5
var respawn_bench:
	set(value):
		if value != null:
			respawn_bench = value
			respawn_point = respawn_bench.global_position
			if respawn_bench.name == "MidBench":
				level_1_half_way = true
var respawn_point:
	set(value):
		respawn_point = value
		print(respawn_point)

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

func _player_died():
	just_died = true
	get_tree().current_scene.animation_player.play("FadeOut")
	#await get_tree().create_timer(4).timeout
	await get_tree().current_scene.animation_player.animation_finished
	await get_tree().reload_current_scene()
	#playable_character.global_position = respawn_point
	pass

func _update_alternate_neu_position():
	get_tree().current_scene.alternate_neu_2d.global_position = get_tree().current_scene.alternate_position.global_position
