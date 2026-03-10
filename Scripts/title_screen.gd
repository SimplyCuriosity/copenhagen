extends Label

var Fonts:Array = [preload("res://Assets/Fonts/Childst_added-Regular.ttf"), preload("res://Assets/Fonts/DigitalHandWritingTest-Regular.ttf"), preload("res://Assets/Fonts/GabilersTerribleFont-Regular.ttf"), preload("res://Assets/Fonts/Italicst_added-Regular.ttf")]
# Called when the node enters the scene tree for the first time.
@onready var timer: Timer = get_parent().get_child(1)
var count: int = 0

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	add_theme_font_override("font",Fonts[count])
	rotation_degrees = randf_range(-5,5)
	count+=1
	if count == 4:
		count = 0
	pass # Replace with function body.
