extends Node2D
@onready var obstacle_animation: AnimationPlayer = $ObstacleAnimation
@onready var countdown: RichTextLabel = $Countdown
@onready var activate: RichTextLabel = $Activate
@onready var danger_totem: Sprite2D = $DangerTotem
@onready var survive: RichTextLabel = $Survive
@onready var start_countdown: RichTextLabel = $CanvasLayer/StartCountdown

signal open_path()

var keep_going:= true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	danger_totem.begin_challenge.connect(_challenge_start)
	countdown.countdown_over_signal.connect(_countdown_over)
	countdown.visible = false
	survive.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_obstacle_animation_animation_finished(anim_name: StringName) -> void:
	if keep_going:
		obstacle_animation.speed_scale *= 1.05
		obstacle_animation.play("Obstacle " + str(randi_range(1,6)))
	elif not keep_going:
		if GameManager.current_level != null:
			if GameManager.current_level.name == "Level 1":
				open_path.emit()
	pass # Replace with function body.
	
func _countdown_over():
	keep_going = false
	countdown.visible = false
	survive.text = "SUCCESS"

func _challenge_start():
	start_countdown.text = str(3)
	await get_tree().create_timer(1).timeout
	start_countdown.text = str(2)
	await get_tree().create_timer(1).timeout
	start_countdown.text = str(1)
	await get_tree().create_timer(1).timeout
	start_countdown.visible = false
	countdown.visible = true
	survive.visible = true
	countdown._counting_down()
	obstacle_animation.play("Obstacle " + str(randi_range(1,6)))
