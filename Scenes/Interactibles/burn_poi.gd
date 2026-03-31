extends Node2D
@onready var interact: RichTextLabel = $Interact
@onready var ashes_flame: GPUParticles2D = $"Ashes flame"
signal extinguished()
signal start_minigame()
var arrow_scene = preload("res://Scenes/UI/arrow.tscn")
var just_once_prime:= false
var Neu_is_here:= false
var burning:= false
var arrow_node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	burning = true
	arrow_node = arrow_scene.instantiate()
	GameManager.playable_character.get_node("Arrows").add_child(arrow_node)
	arrow_node.target = global_position
	arrow_node.pointing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if burning and Neu_is_here:
		interact.visible = true
		if Input.is_action_just_pressed("interact") and name != "Burn POI Prime":
			ashes_flame.emitting = false
			burning = false
			arrow_node.visible = false
			arrow_node.pointing = false
			extinguished.emit()
		elif Input.is_action_just_pressed("interact") and name == "Burn POI Prime":
			if not just_once_prime:
				just_once_prime = true
				ashes_flame.emitting = false
				burning = false
				start_minigame.emit()
			elif just_once_prime:
				ashes_flame.emitting = false
				burning = false
				arrow_node.visible = false
				arrow_node.pointing = false
				extinguished.emit()
	else: interact.visible = false
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = false
	pass # Replace with function body.
