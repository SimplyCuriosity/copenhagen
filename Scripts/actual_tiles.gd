extends TileMapLayer

var found_coords = []
var tile_to_remove = []
var just_once = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return true

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	found_coords.append(coords)
	if coords in tile_to_remove:
		tile_data.modulate.a = 0
		#tile_data.set
		#print(coords)
	pass
