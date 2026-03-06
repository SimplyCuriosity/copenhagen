extends Camera3D

var screenshot_folder = DirAccess.open("res://Screenshots")
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in screenshot_folder.get_files():
		count += 1
	
	await RenderingServer.frame_post_draw
	var viewport = get_viewport()
	var image = viewport.get_texture().get_image()
	image.save_png("res://Screenshots/test_shot" + str(count) + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
