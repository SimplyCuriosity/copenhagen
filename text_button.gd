extends Label
@export var button = Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.focus_entered.connect(_custom_button_focus_entered)
	button.focus_exited.connect(_custom_button_focus_exited)
	button.mouse_entered.connect(_custom_button_mouse_entered)
	button.mouse_exited.connect(_custom_button_mouse_exited)
	button.pressed.connect(_custom_button_pressed)
	
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
	
func _custom_button_mouse_entered() -> void:
	button.focus_entered.emit()
	pass
	
func _custom_button_mouse_exited() -> void:
	button.focus_exited.emit()
	pass

func _custom_button_pressed() -> void:
	match text:
		"Start":
			print(3)
			get_tree().change_scene_to_file("res://Scenes/Levels/intro_level.tscn")
			#GameManager.Background_music.stream = preload("res://Assets/Music/ptt_02.mp3")
			#GameManager.Background_music.playing = true
		"Exit":
			get_tree().quit()
		"Back":
			#if get_tree().current_scene.name == "MainMenu":
			#	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
			#elif get_tree().current_scene.name == "Main":
			#	GameManager.setting_menu.visible = false
			GameManager.setting_menu.visible = false
			if get_tree().current_scene.name == "MainMenu":
				get_tree().current_scene.visible = true
			elif get_tree().current_scene.name != "MainMenu":
				GameManager.pause_overlay.visible = true
				if GameManager.dialogue_system != null:
					GameManager.dialogue_system.visible = true
		"Resume":
			GameManager.Resume_button_pressed = true
			pass
		"Settings":
			print(1)
			
			GameManager.setting_menu.visible = true
			if get_tree().current_scene.name == "MainMenu":
				get_tree().current_scene.visible = false
			elif get_tree().current_scene.name != "MainMenu":
				GameManager.pause_overlay.visible = false
				if GameManager.dialogue_system != null:
					GameManager.dialogue_system.visible = false
		"Main Menu":
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
			GameManager.Background_music.stream = preload("res://Assets/Music/bigj_demo_4.mp3")
			BackgroundMusic.volume_db = 0
			GameManager.Background_music.playing = true
			GameManager.Resume_button_pressed = true
			if GameManager.dialogue_system != null:
				GameManager.dialogue_system.queue_free()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		"Skip All":
			GameManager.dialogue_system._skip_early()
	pass


func _on_button_focus_entered() -> void:
	pass # Replace with function body.


func _on_button_focus_exited() -> void:
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	pass # Replace with function body.
