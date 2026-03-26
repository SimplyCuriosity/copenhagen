extends Node2D
enum Cave_type {
	Level_1_Begin,
	Level_1_End,
	Level_2_Begin,
	Level_2_End,
	Level_3_Begin,
	Level_3_End,
	Level_4_Begin,
	Level_4_End,
}
@export var open:= true
@export var Cave_Id: Cave_type
@onready var interact: RichTextLabel = $Interact
signal change_level(level_num: int)
var Neu_is_here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_level.connect(GameManager._change_level)
	interact.visible = false
	if Cave_Id == Cave_type.Level_1_Begin:
		if GameManager.current_cave == null:
			GameManager.current_cave = self
		interact.text = "[wave]Cave is locked"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Neu_is_here and open:
		match Cave_Id:
			Cave_type.Level_1_Begin:
				#GameManager.current_cave = Cave_type.Level_4_Begin
				pass
			Cave_type.Level_1_End:
				GameManager.current_cave = Cave_type.Level_2_Begin
				change_level.emit(2)
				pass
			Cave_type.Level_2_Begin:
				GameManager.current_cave = Cave_type.Level_1_End
				change_level.emit(1)
				pass
			Cave_type.Level_2_End:
				GameManager.current_cave = Cave_type.Level_3_Begin
				change_level.emit(3)
				pass
			Cave_type.Level_3_Begin:
				GameManager.current_cave = Cave_type.Level_2_End
				change_level.emit(2)
				pass
			Cave_type.Level_3_End:
				GameManager.current_cave = Cave_type.Level_4_Begin
				change_level.emit(4)
				pass
			Cave_type.Level_4_Begin:
				GameManager.current_cave = Cave_type.Level_3_End
				change_level.emit(3)
				pass
			Cave_type.Level_4_End:
				#Ending Cutscene
				pass
				
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = true
			interact.visible = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = false
			interact.visible = false
	pass # Replace with function body.
