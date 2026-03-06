extends Node3D
@onready var label_3d: Label3D = $Label3D
var player_here:= false
var dialogue_scene = preload("res://Scenes/dialogue_system.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here && Input.is_action_just_pressed("interact"):
		var dialogue_node = dialogue_scene.instantiate()
		get_tree().root.add_child(dialogue_node)
		dialogue_node._generate_dialogue_box(dialogue_node.test_script)
		GameManager.playable_character.motion_paused = true
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if body.get_collision_layer_value(2) == true:
			label_3d.visible = true
			player_here = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		if body.get_collision_layer_value(2) == true:
			label_3d.visible = false
			player_here = false
	pass # Replace with function body.
