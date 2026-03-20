extends GPUParticles2D

@export var tiles:TileMapLayer
var tile_to_remove = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == TileMap:
		print("yeah")
		if body.name == "Actual Tiles":
			for tile in tiles:
				if tile*64 <= Vector2i(round(global_position.x),round(global_position.y)) + Vector2i(500,0) and tile*64 >= Vector2i(round(global_position.x),round(global_position.y)) + Vector2i(-500,0):
					tiles.erase_cell(tile)
					tiles.notify_runtime_tile_data_update() 
					print("it happens")
	pass # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		#print("yeah")
		if body.name == "Actual Tiles":
			#print(tiles.found_coords)
			for tile in tiles.found_coords:
				if tile.x*64 <= round(global_position.x) + 500 and tile.x*64 >= round(global_position.x) -500 and tile.y*64 <= round(global_position.y) + 16 and tile.y*64 >= round(global_position.y) -90:
					tiles.erase_cell(tile)
					#tiles.notify_runtime_tile_data_update() 
					tile_to_remove.append(tile)
					#print("it happens")
	#print("tile to remove is", tile_to_remove)
	#tiles.tile_to_remove = tile_to_remove
	tile_to_remove.clear()
	pass # Replace with function body.
