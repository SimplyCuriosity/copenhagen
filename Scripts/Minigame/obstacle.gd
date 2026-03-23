extends Node2D
@onready var tile: TileMapLayer = $Tile
@onready var spikes: Node2D = $Spikes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible == false:
		tile.enabled = false
		for i in spikes.get_children():
			i.area_2d.monitoring = false
	elif visible:
		tile.enabled = true
		for i in spikes.get_children():
			i.area_2d.monitoring = true
	pass
