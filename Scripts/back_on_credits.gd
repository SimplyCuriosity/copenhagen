extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _custom_button_focus_entered() -> void:
	if text ==  "Skip All":
		add_theme_font_size_override("font_size", 28)
	else:
		add_theme_font_size_override("font_size", 144)
	pass
	
func _custom_button_focus_exited() -> void:
	if text ==  "Skip All":
		add_theme_font_size_override("font_size", 24)
	else:
		add_theme_font_size_override("font_size", 122)
	pass

func _on_button_mouse_entered() -> void:
	_custom_button_focus_entered()
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	_custom_button_focus_exited()
	pass # Replace with function body.


func _on_button_focus_entered() -> void:
	_custom_button_focus_entered()
	pass # Replace with function body.


func _on_button_focus_exited() -> void:
	_custom_button_focus_exited()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	GameManager.setting_menu.visible = true
	get_parent().queue_free()
	pass # Replace with function body.
