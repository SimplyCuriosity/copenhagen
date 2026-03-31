extends Node2D
var pointing:= false
var target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pointing and target.distance_to(global_position) >= 50 and GameManager.in_minigame:
		if target != null:
			look_at(target)
			visible = true
		else: visible = false
	else:
		visible = false
	pass
