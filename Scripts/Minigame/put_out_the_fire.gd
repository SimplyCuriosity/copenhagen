extends Node2D
@onready var burn_pois: Node2D = $"Burn POIS"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var alternate_neu_2d: CharacterBody2D = $AlternateNeu2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var fire_left_text: RichTextLabel = $CanvasLayer/FireLeftText


var dialogue_scene = preload("res://Scenes/dialogue_system.tscn")
var burning_poi_num:= 0
signal minigame_finished()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in burn_pois.get_children():
		i.extinguished.connect(_poi_extinguished)
		i.start_minigame.connect(_start_minigame)
		if i.name != "Burn POI Prime":
			i.burning = false
			i.ashes_flame.emitting = false
	canvas_layer.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _poi_extinguished():
	burning_poi_num -= 1
	fire_left_text.text = "FIRE LEFT: " + str(burning_poi_num)
	if burning_poi_num <= 0:
		_minigame_finished()
		pass
	pass

func _start_minigame():
	animation_player.play("StartMinigame")
	await  animation_player.animation_finished
	GameManager.in_minigame = true
	for i in burn_pois.get_children():
		i.burning = true
		i.ashes_flame.emitting = true
		burning_poi_num += 1
	fire_left_text.text = "FIRE LEFT: " + str(burning_poi_num)
	canvas_layer.visible = true
	pass

func _minigame_finished():
	GameManager.in_minigame = false
	GameManager.minigame_2_done = true
	canvas_layer.visible = false
	minigame_finished.emit()
	pass

func _minigame_intro_dialogue():
	#Ag_minigame_intro_dialogue
	var dialogue_node = dialogue_scene.instantiate()
	add_child(dialogue_node)
	GameManager.playable_character.motion_paused = true
	animation_player.pause()
	dialogue_node._generate_dialogue_box(alternate_neu_2d.Ag_minigame_intro_dialogue)
	await dialogue_node.dialogue_finished
	animation_player.play()
	pass
