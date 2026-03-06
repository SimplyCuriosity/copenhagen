extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.setting_menu = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	pass # Replace with function body.


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	pass # Replace with function body.


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	pass # Replace with function body.
