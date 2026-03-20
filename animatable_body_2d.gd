extends AnimatableBody2D
@onready var paper: Sprite2D = $Paper
var test = preload("res://Resources/Paper_burn_gradient.tres")
@onready var fire: GPUParticles2D = $Fire


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#0.01 to 0.58
	paper.material.get_shader_parameter("a").fill_to.y -= 0.025 *delta
	#set_shader_parameter("fill_to", Vector2(0.01,0.0))
	#paper.material.set_shader_parameter("fill_to", Vector2(0.01,0.0))
	fire.position.y -= 38 * delta
	pass
