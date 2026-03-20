extends Node2D
@onready var platform_anim_1: AnimationPlayer = $PlatformAnims/PlatformAnim1
@onready var alternate_neu_2d: CharacterBody2D = $AlternateNeu2D
@onready var alternate_position: Node2D = $AlternatePosition
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
	GameManager.playable_character.motion_paused = true
	animation_player.play("Spawning")
	if GameManager.level_1_half_way:
		GameManager._update_alternate_neu_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	pass # Replace with function body.


func _on_temporary_spike_areas_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
