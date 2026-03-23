extends RichTextLabel
var seconds:= 45
signal countdown_over_signal()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(seconds)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _counting_down():
	if seconds > 0:
		seconds -= 1
		text = str(seconds)
		await get_tree().create_timer(1).timeout
		if seconds == 0:
			countdown_over_signal.emit()
			queue_free()
		_counting_down()
	pass
