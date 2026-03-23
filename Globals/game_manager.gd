extends Node3D

@onready var dim_background: Sprite2D = $"CanvasLayer/Dim background"
@onready var canvas_modulate: CanvasModulate = $CanvasLayer/CanvasModulate 
@onready var pause_overlay: Node2D = $"CanvasLayer/Pause Overlay"
const DENI_THEME = preload("res://Assets/Music/Deni's Theme.ogg")
var stage_open = false
var current_level = null
var playable_character
var third_person_cam 
var game_is_paused: bool = false
var Background_music
var setting_menu
var Resume_button_pressed:= false
var main_menu
var dialogue_system:
	set(value):
		if dialogue_system != null:
			dialogue_system.queue_free()
		dialogue_system = value
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
	
	if current_level != null:
		if current_level.name == "Level 1" and Background_music.stream != DENI_THEME:
			Background_music.stream = DENI_THEME
			BackgroundMusic.volume_db = -10
			Background_music.playing = true
	pass

func _player_died():
	just_died = true
	print(get_tree().current_scene)
	if current_level != null:
		get_tree().current_scene.animation_player.play("FadeOut")
		#await get_tree().create_timer(4).timeout
		await get_tree().current_scene.animation_player.animation_finished
		print("happen here")
		await get_tree().reload_current_scene()
		#playable_character.global_position = respawn_point
	get_tree().reload_current_scene()
	pass

func _update_alternate_neu_position():
	get_tree().current_scene.alternate_neu_2d.global_position = get_tree().current_scene.alternate_position.global_position

func _player_save_checkpoint():
	GameManager.playable_character.motion_paused = true
	get_tree().current_scene.animation_player.play("FadeOut")
	await get_tree().current_scene.animation_player.animation_finished
	
	if level_1_half_way:
		_update_alternate_neu_position()
	
	get_tree().current_scene.animation_player.play("FadeIn")
	await get_tree().current_scene.animation_player.animation_finished
	GameManager.playable_character.motion_paused = false
	if level_1_half_way and not stage_open:
		stage_open = true
		_stage_opening()
	

func _stage_opening():
	#fade out 
	GameManager.playable_character.motion_paused = true
	get_tree().current_scene.animation_player.play("FadeOut")
	
	await get_tree().current_scene.animation_player.animation_finished
	#change cam
	GameManager.playable_character.motion_paused = true
	current_level.world_cam.position_smoothing_enabled = false
	current_level.world_cam.global_position = playable_character.camera_2d.global_position
	current_level.world_cam.make_current()
	#fade in
	get_tree().current_scene.animation_player.play("FadeIn")
	
	await get_tree().current_scene.animation_player.animation_finished
	#play anim
	current_level.animation_player.get_animation("Stage2Open").track_set_key_value(2,0,current_level.world_cam.global_position)
	get_tree().current_scene.animation_player.play("Stage2Open")
	current_level.world_cam.position_smoothing_enabled = false
	await get_tree().current_scene.animation_player.animation_finished
	#when anim finished (with fadeout), fade in again 
	playable_character.camera_2d.make_current()
	get_tree().current_scene.animation_player.play("FadeIn")
	await get_tree().current_scene.animation_player.animation_finished
	
	GameManager.playable_character.motion_paused = false
	pass
