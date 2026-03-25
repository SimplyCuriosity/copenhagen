extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var alternate_neu_2d: CharacterBody2D = $AlternateNeu2D
@onready var ending_trigger: Area2D = $EndingTrigger
@onready var mid_barrier: TileMapLayer = $Barriers/MidBarrier


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.current_level = self
	GameManager.playable_character.motion_paused = true
	#animation_player.play("Spawning")
	
	# Handles alternate Neu at start
	if GameManager.level_2_half_way:
		if not GameManager.level_2_outro_done:
			GameManager._update_alternate_neu_position()
		elif GameManager.level_2_outro_done:
			alternate_neu_2d.queue_free()
			ending_trigger.monitoring = false
		
		if GameManager.stage_open_2:
			mid_barrier.enabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Spawning" and GameManager.just_died == true:
		GameManager.just_died = false
		if GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
	elif anim_name == "Spawning":
		if GameManager.dialogue_system == null:
			GameManager.playable_character.motion_paused = false
	elif anim_name == "Outro":
		GameManager.level_2_outro_done = true
	pass # Replace with function body.
