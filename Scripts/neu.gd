extends CharacterBody3D
@onready var placeholder_cat: Node3D = $"Placeholder cat"
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var origin_angle: Node3D = $origin_angle

const SPEED = 15
const JUMP_VELOCITY = 25
var gravity_double = false
var gravity_multiplier:float = 1
var double_jump = false
var look_at_dir: Vector3

func _ready() -> void:
	GameManager.playable_character = self
	look_at_dir = global_position
	pass
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if not gravity_double and velocity.y<0:
			gravity_double = true
			gravity_multiplier = 3
		velocity += get_gravity() * delta * gravity_multiplier * 3

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		gravity_multiplier = 1
		gravity_double = false
		velocity.y = JUMP_VELOCITY 
		
	# Start falling as soon as jump button is released
	if Input.is_action_just_released("Jump") && velocity.y >0:
		velocity.y = 0
	

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	direction = direction.rotated(Vector3.UP, GameManager.third_person_cam.camera_3d.global_rotation.y)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	look_at_dir = global_position + direction*2
		
	if global_position != global_position + direction:
		origin_angle.look_at(global_position + direction)
		#collision_shape_3d.look_at(global_position + direction)
		
		# This don't work :(
		#var positive_angle
		#var negative_angle
		#if origin_angle.global_rotation.y < 0:
		#	negative_angle = origin_angle.global_rotation.y
		#	positive_angle = negative_angle + 2*PI
		#elif origin_angle.global_rotation.y >= 0:
		#	positive_angle = origin_angle.global_rotation.y
		#	negative_angle = positive_angle - 2*PI
		
		#if abs(placeholder_cat.global_rotation.y - negative_angle) <= abs(placeholder_cat.global_rotation.y -positive_angle):
		#	placeholder_cat.rotation.y = move_toward(placeholder_cat.global_rotation.y, negative_angle, -0.2)
		#elif abs(placeholder_cat.global_rotation.y - negative_angle) >= abs(placeholder_cat.global_rotation.y -positive_angle):
		#	placeholder_cat.rotation.y = move_toward(placeholder_cat.global_rotation.y, positive_angle, +0.2)
		
		# This one line does what I thought the above would do
		placeholder_cat.rotation.y = rotate_toward(placeholder_cat.global_rotation.y, origin_angle.global_rotation.y, 0.2) 
		collision_shape_3d.rotation.y = rotate_toward(collision_shape_3d.global_rotation.y, origin_angle.global_rotation.y, 0.2) 
	move_and_slide()
