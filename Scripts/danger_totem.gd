extends Sprite2D
@onready var activate: RichTextLabel = $Activate
var player_in:= false
signal begin_challenge()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activate.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		begin_challenge.emit()
		if GameManager.current_level != null:
			if GameManager.current_level.name == "Level 1":
				GameManager.current_level.mid_barrier.enabled = true 
		queue_free()
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			activate.visible = true
			player_in = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			activate.visible = false
			player_in = false
	pass # Replace with function body.
