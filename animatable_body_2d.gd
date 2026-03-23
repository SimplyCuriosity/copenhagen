extends AnimatableBody2D
@onready var paper: Sprite2D = $Paper
var test = preload("res://Resources/Paper_burn_gradient.tres")
@onready var fire: GPUParticles2D = $Fire
@export var burnable_tiles: TileMapLayer
var burning := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paper.set_material(paper.material.duplicate_deep())
	if burnable_tiles != null:
		fire.tiles = burnable_tiles
	elif burnable_tiles == null:
		fire.tiles.enabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#0.01 to 0.58
	if burning:
		paper.material.get_shader_parameter("a").fill_to.y -= 0.025 *delta
	#set_shader_parameter("fill_to", Vector2(0.01,0.0))
	#paper.material.set_shader_parameter("fill_to", Vector2(0.01,0.0))
		fire.position.y -= 38 * delta
	if paper.material.get_shader_parameter("a").fill_to.y < 0:
		queue_free()
	
	pass


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			#_ignite_fire()
			burning = true
	pass # Replace with function body.

func _ignite_fire():
	fire.emitting = true
	fire.smoke.emitting = true
	fire.ashes.emitting = true
