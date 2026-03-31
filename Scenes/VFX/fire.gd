extends GPUParticles2D
@onready var smoke: GPUParticles2D = $Smoke
@onready var ashes: GPUParticles2D = $Ashes
@onready var right_cast: RayCast2D = $RightCast
@onready var left_cast: RayCast2D = $LeftCast

@export var tiles:TileMapLayer
var tile_to_remove = []
var in_tile:= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		#print("yeah")
		if body.name == "BurnableTiles":
			#print(tiles.found_coords)
			#500, -500, 16, -90
			#print(tiles.get_coords_for_body_rid(body_rid))
			
			#tiles.erase_cell(tiles.get_coords_for_body_rid(body_rid))
			
			#miracle
			
			
			tiles.set_cell(tiles.get_coords_for_body_rid(body_rid),-1)
			tiles.queue_redraw()
			#below is old code
			#for tile in tiles.found_coords:
			#	if tile.x*64 <= round(global_position.x) + 500 and tile.x*64 >= round(global_position.x) -500 and tile.y*64 <= round(global_position.y) + 16 and tile.y*64 >= round(global_position.y) -90:
			#		tiles.erase_cell(tile)
			#		tiles.found_coords.erase(tile)
			#		#tiles.notify_runtime_tile_data_update() 
			#		tile_to_remove.append(tile)
	elif body is AnimatableBody2D:
		body.queue_free()
			
					#print("it happens")
	#print("tile to remove is", tile_to_remove)
	#tiles.tile_to_remove = tile_to_remove
	
	#tile_to_remove.clear()
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	pass # Replace with function body.


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area is Area2D:
		if area.get_collision_layer_value(6) == true:
			area.get_parent().queue_free()
	pass # Replace with function body.
