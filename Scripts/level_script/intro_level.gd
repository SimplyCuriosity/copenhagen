extends Node2D
@onready var world_cam: Camera2D = $WorldCam
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var dialogue_scene = preload("res://Scenes/dialogue_system.tscn")
var mystery_dialogue = "Unknown Narrator:
So... your attempting the climb again.
I see... You have tried before.
You have failed before.
Yet... you go on.
You know damn well that this is no easy task.
You know it’s easy to just give up and call it quits.
But you haven’t.
Neu:
.
.
.
"
var mystery_dialogue_2 = "Unknown Narrator:
.
.
.
"
var mystery_dialogue_3 = "
Unknown Narrator:
A crossroads lays ahead of you. 
Only you know where to go next, Neu.
And I trust you’ll pick the right choice.
Good luck... You’ll need it.
"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_cam.make_current()
	GameManager.playable_character.motion_paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _play_intro_dialogue():
	var dialogue_node = dialogue_scene.instantiate()
	get_tree().root.add_child(dialogue_node)
	animation_player.pause()
	dialogue_node._generate_dialogue_box(mystery_dialogue)
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()

func _play_intro_dialogue_2():
	var dialogue_node = dialogue_scene.instantiate()
	get_tree().root.add_child(dialogue_node)
	animation_player.pause()
	dialogue_node._generate_dialogue_box(mystery_dialogue_2)
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()
	_play_intro_dialogue_3()

func _play_intro_dialogue_3():
	var dialogue_node = dialogue_scene.instantiate()
	get_tree().root.add_child(dialogue_node)
	animation_player.pause()
	dialogue_node._generate_dialogue_box(mystery_dialogue_3)
	await dialogue_node.dialogue_finished
	GameManager.playable_character.motion_paused = true
	animation_player.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.
