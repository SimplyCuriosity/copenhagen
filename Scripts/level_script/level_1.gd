extends Node2D
@onready var platform_anim_1: AnimationPlayer = $PlatformAnims/PlatformAnim1
@onready var alternate_neu_2d: CharacterBody2D = $AlternateNeu2D
@onready var alternate_position: Node2D = $AlternatePosition
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var platform_anim_2: AnimationPlayer = $PlatformAnims/PlatformAnim2
@onready var world_cam: Camera2D = $WorldCam
@onready var mid_barrier: TileMapLayer = $Barriers/MidBarrier
@onready var burning_paper: AnimatableBody2D = $"Burning Papers/Burning Paper"
@onready var hole_in_the_wall: Node2D = $HoleInTheWall
@onready var ending_trigger: Area2D = $EndingTrigger


var dialogue_scene = preload("res://Scenes/dialogue_system.tscn")

var deni_speech_1 = "Deni:
You’re really going at it again?
After all of that?
Heh…
So naive.
I would’ve stopped the moment I realized how far you’d have to go to reach [wave]The Outside[/wave].
As a matter of fact… I have.
There is nothing beyond [wave]The Outside[/wave]for you.
Nothing but more pain and suffering.
Best to finish before you start.
"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameManager.respawn_point)
	GameManager.current_level = self
	GameManager.playable_character.motion_paused = true
	hole_in_the_wall.open_path.connect(_minigame_finished)
	if GameManager.respawn_point != null:
		GameManager.playable_character.global_position = GameManager.respawn_point
	animation_player.play("Spawning")
	
	
	# Handles alternate Neu at start
	if GameManager.level_1_half_way:
		GameManager._update_alternate_neu_position()
		if GameManager.stage_open:
			mid_barrier.enabled = false
		
	if GameManager.level_1_outro_done:
		alternate_neu_2d.queue_free()
		ending_trigger.monitoring = false
		mid_barrier.enabled = false
		platform_anim_2.play("MoveToPosition")
		platform_anim_1.play("Platform")


			
	# Handles state of a platform 
	if GameManager.minigame_1_done:
		platform_anim_2.play("MoveToPosition")
		hole_in_the_wall.danger_totem.queue_free()
	else:
		platform_anim_2.play("NotInPosition")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#world_cam.global_position = GameManager.playable_character.camera_2d.global_position
	#animation_player.get_animation("Stage2Open").track_set_key_value()
	pass


func _on_player_detect_body_entered(body: Node2D) -> void:
	platform_anim_1.play("Platform")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Spawning" and GameManager.just_died == true:
		GameManager.just_died = false
		if GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
	elif anim_name == "Spawning":
		if GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
	elif anim_name == "Outro":
		GameManager.level_1_outro_done = true
	pass # Replace with function body.


func _on_temporary_spike_areas_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	

func _minigame_finished():
	mid_barrier.enabled = false
	GameManager.minigame_1_done = true
	platform_anim_2.play("MoveToPosition")
	pass


func _on_ending_trigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			ending_trigger.monitoring = false
			if not GameManager.level_1_outro_done:
				ending_trigger.monitoring = false
				ending_trigger.set_monitoring(false)
				GameManager.playable_character.motion_paused = true
				await _update_neu_key()
				await get_tree().create_timer(1).timeout
				animation_player.play("Outro")
				#ending_trigger.queue_free()
		
	pass # Replace with function body.
	

func _play_outro_dialogue_1():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.deni_end_speech[0])
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	pass

func _play_outro_dialogue_2():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.deni_end_speech[1])
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	pass

func _play_outro_dialogue_3():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.deni_end_speech[2])
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	pass

func _play_outro_dialogue_4():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.deni_end_speech[3])
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	pass

func _play_outro_dialogue_5():
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.deni_end_speech[4])
	await dialogue_node.dialogue_finished
	animation_player.play()
	await get_tree().current_scene.animation_player.animation_finished
	GameManager.playable_character.motion_paused = false
	pass
func _enable_world_cam():
	
	pass

func _enable_player_cam():
	pass

func _update_neu_key():
	#animation_player.get_animation("Outro").track_set_key_value(7,0,GameManager.playable_character.global_position.x)
	animation_player.get_animation("Outro").track_set_key_value(7,0,0.0)
	pass
