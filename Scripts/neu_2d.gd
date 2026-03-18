extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_meter_slider: HSlider = $JumpMeterSlider
@onready var wall_climb_meter_slider: HSlider = $WallClimbMeterSlider
@onready var charge_jump_audio: AudioStreamPlayer = $Charge_Jump_Audio
@onready var jump_audio: AudioStreamPlayer = $Jump_Audio
@onready var landing_audio: AudioStreamPlayer = $"Landing Audio"
@onready var camera_cast: RayCast2D = $CameraCast
@onready var camera_2d: Camera2D = $Camera2D


const SPEED = 450.0
const MAX_JUMP_VELOCITY = -1000
var JUMP_VELOCITY = 0
var jump_meter_going_up = true
const MAX_WALL_CLIMB_STAMINA = 100
var wall_climb_stamina = 100
var motion_paused 
var test_pitch = randf_range(0.1,0.2)
var just_landed := false
var manual_jump:= false


func _ready() -> void:
	GameManager.playable_character = self
	if not GameManager.just_died:
		GameManager.respawn_point = global_position
	elif GameManager.just_died:
		global_position = GameManager.respawn_point
	jump_meter_slider.visible = false
	jump_meter_slider.max_value = -MAX_JUMP_VELOCITY
	wall_climb_meter_slider.visible = false
	wall_climb_meter_slider.max_value = MAX_WALL_CLIMB_STAMINA
	wall_climb_meter_slider.value = MAX_WALL_CLIMB_STAMINA
	pass
	

func _process(delta: float) -> void:
	
	pass

func _physics_process(delta: float) -> void:
	# Adjust Camera Height
	if Input.is_action_pressed("Move Forward") and not motion_paused:
		camera_2d.global_position.y = move_toward(camera_2d.global_position.y,GameManager.playable_character.global_position.y - 300 +25, delta*500)
		#camera_2d.global_position = camera_2d.global_position.round().lerp(GameManager.playable_character.global_position - Vector2(0,400 +10), delta*5)
		#camera_2d.global_position = camera_2d.global_position.round()
	elif Input.is_action_pressed("Move Backward") and not motion_paused:
		camera_2d.global_position.y = move_toward(camera_2d.global_position.y, GameManager.playable_character.global_position.y + 350, delta*500)
	elif camera_cast.is_colliding() == true and not Input.is_action_pressed("Jump"):
		camera_2d.global_position.y = move_toward(camera_2d.global_position.y, camera_cast.get_collision_point().y -300, delta*500)
		#camera_2d.global_position.y = clampf(-1000,1000)
		#camera_2d.global_position = camera_2d.global_position.round().lerp(camera_cast.get_collision_point().round() - Vector2(0,400), delta*5)
		#camera_2d.global_position = camera_2d.global_position.round()
	elif camera_cast.is_colliding() == false and not Input.is_action_pressed("Jump"):
		camera_2d.global_position.y = move_toward(camera_2d.global_position.y, GameManager.playable_character.global_position.y + 350, delta*500)
		#camera_2d.global_position.y = lerpf(camera_2d.global_position.y, 1000, delta*500)
		#camera_2d.global_position = camera_2d.global_position.round()
		pass
	#camera_2d.global_position = camera_2d.global_position.round()
	# Add the gravity.
	if is_on_wall_only() and wall_climb_stamina > 0 and Input.is_action_pressed("Jump") and not motion_paused:
		pass
	elif not is_on_floor():
		velocity += get_gravity() * delta
		jump_meter_slider.visible = false
		wall_climb_meter_slider.visible = false
		JUMP_VELOCITY = 0
		just_landed = false
		pass
	if is_on_floor() and not just_landed:
		just_landed = true
		landing_audio.pitch_scale = randf_range(0.9,1.1)
		landing_audio.play()
		
	# Handle jump.
	if JUMP_VELOCITY >= 0:
		jump_meter_going_up = true
		charge_jump_audio.stop()
	elif JUMP_VELOCITY <= MAX_JUMP_VELOCITY:
		jump_meter_going_up = false
		
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not motion_paused:
		test_pitch = randf_range(0.1,0.2)
		#charge_jump_audio.play()
	
	if Input.is_action_pressed("Jump") and is_on_floor() and not motion_paused:
		jump_meter_slider.visible = true
		wall_climb_stamina = MAX_WALL_CLIMB_STAMINA
		if charge_jump_audio.playing == false:
			charge_jump_audio.play()
		charge_jump_audio.pitch_scale = (JUMP_VELOCITY/(MAX_JUMP_VELOCITY/0.2))+test_pitch
		if JUMP_VELOCITY > MAX_JUMP_VELOCITY and jump_meter_going_up:
			JUMP_VELOCITY += -600 * delta
			jump_meter_slider.value = -JUMP_VELOCITY
			#print(JUMP_VELOCITY)
		elif JUMP_VELOCITY < 0 and not jump_meter_going_up:
			JUMP_VELOCITY += 600 * delta
			jump_meter_slider.value = -JUMP_VELOCITY
			#print(JUMP_VELOCITY)
	
	# Handle wall climb
	if is_on_wall_only() and wall_climb_stamina > 0:
		if Input.is_action_pressed("Jump") and not motion_paused:
			wall_climb_meter_slider.visible = true
			velocity.y = -SPEED/4
			wall_climb_stamina -= 50*delta
			wall_climb_meter_slider.value = wall_climb_stamina
			#print(wall_climb_stamina)
	
	if Input.is_action_just_released("Jump") and is_on_floor() and not motion_paused:
		charge_jump_audio.stop()
		jump_audio.pitch_scale = randf_range(0.9,1.1)
		jump_audio.play()
		jump_meter_slider.visible = false
		velocity.y = JUMP_VELOCITY
		JUMP_VELOCITY = 0
		jump_meter_slider.value = 0
	
	if is_on_floor_only():
		wall_climb_meter_slider.visible = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move Left", "Move Right")
	if direction and not motion_paused:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip direction of character sprite depending on direction 
	if direction > 0 and not motion_paused:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.offset.x = 628.005
		#if jump_meter_slider.position.x < 0:
		#	jump_meter_slider.position.x *= -1
	elif direction < 0 and not motion_paused:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.offset.x = -628.005
		#if jump_meter_slider.position.x > 0:
		#	jump_meter_slider.position.x *= -1
	move_and_slide()

func _animation_jump():
	print("its jumping time")
	velocity.y = -800


func _on_fall_kill_zone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
