extends Camera2D

var shake:float = 3.0
var shaking:= false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shaking:
		offset.x = randf_range(-shake,shake)
		offset.y = randf_range(-shake,shake)
		shake -= delta*30
		if shake <= 0:
			shaking = false
	pass

func shake_cam(shake_strength:float):
	shake = shake_strength
	shaking = true
	pass
