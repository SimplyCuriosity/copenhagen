extends MeshInstance3D
@onready var clockwise: Node3D = $Clockwise
@onready var counter_clockwise: Node3D = $CounterClockwise



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clockwise.rotation.y = clockwise.rotation.y + (delta * 0.2)
	counter_clockwise.rotation.y = counter_clockwise.rotation.y - (delta * 0.2)
	#plat_1.global_position = pos_1.global_position
	#plat_2.global_position = pos_2.global_position
	#plat_3.global_position = pos_3.global_position
	#plat_4.global_position = pos_4.global_position
	
	
	pass
