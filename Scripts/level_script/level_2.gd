extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var alternate_neu_2d: CharacterBody2D = $AlternateNeu2D
@onready var ending_trigger: Area2D = $EndingTrigger
@onready var mid_barrier: TileMapLayer = $Barriers/MidBarrier
@export  var debugging:= false
@onready var cave_2: Node2D = $Caves/Cave2
@onready var alternate_position: Node2D = $AlternatePosition
@onready var world_cam: Camera2D = $WorldCam
@onready var put_out_the_fire: Node2D = $"Put Out The Fire"
@onready var cave: Node2D = $Caves/Cave


const dialogue_scene = preload("res://Scenes/dialogue_system.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.current_level = self
	GameManager.playable_character.motion_paused = true
	put_out_the_fire.minigame_finished.connect(_minigame_finished)
	alternate_neu_2d.interactible = false
	if debugging:
		animation_player.play("Spawning")
	
	# Handles alternate Neu at start
	if GameManager.level_2_half_way:
		if not GameManager.level_2_outro_done:
			GameManager._update_alternate_neu_position()
		elif GameManager.level_2_outro_done:
			alternate_neu_2d.queue_free()
			ending_trigger.monitoring = false
		
		if GameManager.stage_open_2:
			mid_barrier.enabled = false
	
	if GameManager.minigame_2_done:
		put_out_the_fire.burn_pois.get_node("Burn POI Prime").burning = false
		put_out_the_fire.burn_pois.get_node("Burn POI Prime").ashes_flame.emitting = false
	
	if GameManager.level_2_outro_done:
		cave.open = true
		alternate_neu_2d.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Spawning" and GameManager.just_died == true:
		GameManager.just_died = false
		if GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
		cave_2.open = true
	elif anim_name == "Spawning":
		if not GameManager.ag_intro_done:
			cave_2.open = false
			animation_player.play("Ag Intro")
		elif GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
			cave_2.open = true
	elif anim_name == "Outro":
		GameManager.level_2_outro_done = true
	elif anim_name == "Ag Intro":
		GameManager.playable_character.motion_paused = false
		GameManager.ag_intro_done = true
		cave_2.open = true
	pass # Replace with function body.


func _play_intro_dialogue_1():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.Ag_intro_dialogue[0])
	await dialogue_node.dialogue_finished
	animation_player.play()
	pass

func _play_intro_dialogue_2():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.Ag_intro_dialogue[1])
	await dialogue_node.dialogue_finished
	animation_player.play()
	pass

func _minigame_finished():
	GameManager.minigame_2_done = true
	cave.open = true
	GameManager.playable_character.stop_all_motion = true
	GameManager.playable_character.motion_paused = true
	animation_player.play("Ag Outro")
	await animation_player.animation_finished
	GameManager.level_2_outro_done = true
	GameManager.playable_character.stop_all_motion = false
	GameManager.playable_character.motion_paused = false

func _play_outro_dialogue_1():
	GameManager.playable_character.motion_paused = true
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.Ag_end_speech)
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	pass
