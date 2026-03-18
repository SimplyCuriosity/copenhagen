extends Node2D
@onready var interact: RichTextLabel = $Interact
var Neu_is_here = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Neu_is_here:
		GameManager.respawn_bench = self
	pass


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = true
			interact.visible = true
	pass # Replace with function body.


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = false
			interact.visible = false
	pass # Replace with function body.
