extends Node3D
@onready var y_anchor: Node3D = $"Y Anchor"
@onready var x_anchor: Node3D = $"Y Anchor/X Anchor"
@onready var camera_3d: Camera3D = $"Y Anchor/X Anchor/SpringArm3D/Camera3D"


var last_mouse_velocity 
var mouse_sensitifity = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.third_person_cam = self
	print(2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
	

func _physics_process(delta: float) -> void:
	#global_position = GameManager.playable_character.global_position
	x_anchor.rotation_degrees[0] += delta*Input.get_last_mouse_velocity()[1]* - mouse_sensitifity
	y_anchor.rotation_degrees[1] += delta*Input.get_last_mouse_velocity()[0]* - mouse_sensitifity
	x_anchor.rotation_degrees[0] = clampf(x_anchor.rotation_degrees[0], -90,15)
	
	# Rotate camera based on the movement of the mouse
	
	#y_anchor.rotation_degrees[1] = clampf(x_anchor.rotation_degrees[1], -90,15)
	#print("x = " + str(x_anchor.rotation_degrees[0]))
	#print("y = " + str(y_anchor.rotation_degrees[1]))
	pass

func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
	#	x_anchor.rotation_degrees[0] += Input.get_last_mouse_velocity()[1]* - mouse_sensitifity * 0.01
	#	y_anchor.rotation_degrees[1] += Input.get_last_mouse_velocity()[0]* - mouse_sensitifity *0.01
	#	x_anchor.rotation_degrees[0] = clampf(x_anchor.rotation_degrees[0], -90,15)
	pass
