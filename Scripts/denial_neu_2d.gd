extends CharacterBody2D
@onready var talk: RichTextLabel = $Talk

var Neu_is_here:= false
var dialogue_scene = preload("res://Scenes/dialogue_system.tscn") 

func _ready() -> void:
	talk.visible = false
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Neu_is_here:
		var dialogue_node = dialogue_scene.instantiate()
		get_tree().root.add_child(dialogue_node)
		dialogue_node._generate_dialogue_box(dialogue_node.test_script)
		GameManager.playable_character.motion_paused = true
	move_and_slide()



func _on_dialogue_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = true
			talk.visible = true
	pass # Replace with function body.


func _on_dialogue_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = false
			talk.visible = false
	pass # Replace with function body.
