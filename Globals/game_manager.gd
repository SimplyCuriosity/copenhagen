extends Node3D

@onready var dim_background: Sprite2D = $"CanvasLayer/Dim background"
@onready var canvas_modulate: CanvasModulate = $CanvasLayer/CanvasModulate 
@onready var pause_overlay: Node2D = $"CanvasLayer/Pause Overlay"
@onready var checkpoint_audio: AudioStreamPlayer = $CheckpointAudio
@onready var player_died_audio: AudioStreamPlayer = $PlayerDiedAudio

const MAIN_THEME = preload("res://Assets/Music/bigj_demo_4.mp3")
const DENI_THEME = preload("res://Assets/Music/Deni's Theme.ogg")
const AG_THEME = preload("res://Assets/Music/Ag's_Theme.ogg")
const MINIGAME_THEME = preload("res://Assets/Music/Minigame.ogg")
const RESS_THEME = preload("res://Assets/Music/Ress's Theme.ogg")
const DIALOGUE_SCENE = preload("res://Scenes/dialogue_system.tscn")

var credits_scene
var main_menu
var Background_music
var setting_menu
var playable_character
var third_person_cam 
var current_level = null
var game_is_paused: bool = false
var Resume_button_pressed:= false
var dialogue_system:
	set(value):
		if dialogue_system != null:
			dialogue_system.queue_free()
		dialogue_system = value
var just_died:= false
var in_minigame:= false


#Require save is below
var current_cave: #in the form of enum value
	set(value):
		current_cave = value
			
			

var stage_open = false
var stage_open_2 = false
var stage_open_3 = false
var stage_open_4 = false


#var current_scene
var deni_speech_num = 0
var deni_speech_max = 1
var deni_dead_speech_num = 0
var deni_dead_speech_max = 9

var ag_intro_done:= false
var ag_speech_num = 0
var ag_speech_max = 1
var ag_dead_speech_num = 0
var ag_dead_speech_max = 9

var gai_speech_num = 0
var gai_speech_max = 1
var gai_dead_speech_num = 0
var gai_dead_speech_max = 9

var ress_speech_num = 0
var ress_speech_max = 1
var ress_dead_speech_num = 0
var ress_dead_speech_max = 9


var level_1_half_way:= false:
	set(value):
		level_1_half_way = value
		if value == true:
			if get_tree().current_scene.name == "Level 1":
				deni_dead_speech_num = 5
var level_2_half_way:= false:
	set(value):
		level_2_half_way = value
		if value == true:
			if get_tree().current_scene.name == "Level 2":
				ag_dead_speech_num = 5
var level_3_half_way:= false:
	set(value):
		level_3_half_way = value
		if value == true:
			if get_tree().current_scene.name == "Level 3":
				gai_dead_speech_num = 5
var level_4_half_way:= false:
	set(value):
		level_4_half_way = value
		if value == true:
			if get_tree().current_scene.name == "Level 4":
				ress_dead_speech_num = 5


var respawn_bench:
	set(value):
		if value != null:
			respawn_bench = value
			respawn_point = respawn_bench.global_position
			if respawn_bench.name == "MidBench":
				if get_tree().current_scene.name == "Level 1":
					level_1_half_way = true
				elif get_tree().current_scene.name == "Level 2":
					level_2_half_way = true
				elif get_tree().current_scene.name == "Level 3":
					level_3_half_way = true
				elif get_tree().current_scene.name == "Level 4":
					level_4_half_way = true
var respawn_point:
	set(value):
		respawn_point = value
		

var minigame_1_done:= false
var minigame_2_done:= false
var minigame_3_done:= false
var minigame_4_done:= false

var level_1_outro_done:= false:
	set(value):
		level_1_outro_done = value
		if level_1_outro_done:
			minigame_1_done = true
			level_1_half_way = true
			deni_speech_num = deni_speech_max
			deni_dead_speech_num = deni_dead_speech_max +1
			stage_open = true

var level_2_outro_done:= false:
	set(value):
		level_2_outro_done = value
		if level_2_outro_done:
			minigame_2_done = true
			level_2_half_way = true
			ag_intro_done = true
			ag_speech_num = ag_speech_max
			ag_dead_speech_num = ag_dead_speech_max +1
			stage_open_2 = true

var level_3_outro_done:= false:
	set(value):
		level_3_outro_done = value
		if level_3_outro_done:
			minigame_3_done = true
			level_3_half_way = true
			gai_speech_num = gai_speech_max
			gai_dead_speech_num = gai_dead_speech_max +1
			stage_open_3 = true

var level_4_outro_done:= false:
	set(value):
		level_4_outro_done = value
		if level_4_outro_done:
			minigame_4_done = true
			level_4_half_way = true
			ress_speech_num = ress_speech_max
			ress_dead_speech_num = ress_dead_speech_max +1
			stage_open_4 = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	if current_level != null:
		if current_level.name == "Level 1" and BackgroundMusic.music_cue != DENI_THEME and not in_minigame:
			#Background_music.stream = DENI_THEME
			#BackgroundMusic.volume_db = -8
			#Background_music.playing = true
			BackgroundMusic._change_music(DENI_THEME, -8)
		elif current_level.name == "Level 2" and BackgroundMusic.music_cue != AG_THEME and not in_minigame:
			#Background_music.stream = AG_THEME
			#BackgroundMusic.volume_db = -5
			#Background_music.playing = true
			BackgroundMusic._change_music(AG_THEME, -5)
		elif in_minigame and BackgroundMusic.music_cue != MINIGAME_THEME:
			#Background_music.stream = MINIGAME_THEME
			#BackgroundMusic.volume_db = -5
			#Background_music.playing = true
			BackgroundMusic._change_music(MINIGAME_THEME, -12)
		pass
	elif get_tree().current_scene != null:
			if get_tree().current_scene.name == "MainMenu" and BackgroundMusic.music_cue != MAIN_THEME:
				#Background_music.stream = MAIN_THEME
				#BackgroundMusic.volume_db = 0
				#Background_music.playing = true
				BackgroundMusic._change_music(MAIN_THEME, 0)
			elif get_tree().current_scene.name == "Intro Level" and BackgroundMusic.music_cue != RESS_THEME:
				BackgroundMusic._change_music(RESS_THEME, -5)
	elif in_minigame and BackgroundMusic.music_cue != MINIGAME_THEME:
		BackgroundMusic._change_music(MINIGAME_THEME, -12)
	await get_tree().create_timer(0.2).timeout
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (game_is_paused and Input.is_action_just_pressed("Pause")) or Resume_button_pressed:
		game_is_paused = false
		get_tree().paused = false
		pause_overlay.visible = false
		if get_tree().current_scene != null:
			if get_tree().current_scene.name != "MainMenu":
				#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				pass
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
	player_died_audio.play()
	in_minigame = false
	if current_level != null:
		get_tree().current_scene.animation_player.play("FadeOut")
		#await get_tree().create_timer(4).timeout
		await get_tree().current_scene.animation_player.animation_finished
		await get_tree().reload_current_scene()
		#playable_character.global_position = respawn_point
	get_tree().reload_current_scene()
	pass

func _update_alternate_neu_position():
	get_tree().current_scene.alternate_neu_2d.global_position = get_tree().current_scene.alternate_position.global_position

func _player_save_checkpoint():
	#play sound
	checkpoint_audio.play()
	#fade out
	GameManager.playable_character.motion_paused = true
	get_tree().current_scene.animation_player.play("FadeOut")
	await get_tree().current_scene.animation_player.animation_finished
	
	# update alternate neu position if still not absorbed
	if level_1_half_way and not level_1_outro_done and current_level.name == "Level 1":
		_update_alternate_neu_position()
	elif level_2_half_way and not level_2_outro_done and current_level.name == "Level 2":
		_update_alternate_neu_position()
	#fade in
	get_tree().current_scene.animation_player.play("FadeIn")
	await get_tree().current_scene.animation_player.animation_finished
	GameManager.playable_character.motion_paused = false
	
	# open stages
	if level_1_half_way and not stage_open:
		stage_open = true
		_stage_opening()
	elif level_2_half_way and not stage_open_2:
		stage_open_2 = true
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

func _change_level(level_num:int):
	GameManager.playable_character.motion_paused = true
	get_tree().current_scene.animation_player.play("FadeOut")
	await get_tree().current_scene.animation_player.animation_finished
	current_level = null
	await get_tree().change_scene_to_file("res://Scenes/Levels/level_"+str(level_num)+".tscn")
	await get_tree().tree_changed
	
	if current_cave != null:
		for i in current_level.get_node("Caves").get_children():
			if i.Cave_Id == current_cave:
				respawn_point = i.global_position
		playable_character.global_position = respawn_point
		current_level.animation_player.play("Spawning")
	
	await current_level.animation_player.animation_finished
	
	
	pass
