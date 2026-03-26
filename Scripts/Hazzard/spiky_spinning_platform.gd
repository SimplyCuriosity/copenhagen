extends AnimatableBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var start_time: float
@export var play_from_start:= true
enum direction {
	Safe,
	Spike
}
@export var orientation: direction
var begin:= false:
	set(value):
		begin = value
		if value:
			if orientation == direction.Safe:
				animation_player.play("SpikeUP")
			elif orientation == direction.Spike:
				animation_player.play("SpikeDown")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if play_from_start:
		await get_tree().create_timer(start_time).timeout
		if orientation == direction.Safe:
			animation_player.play("SpikeUP")
		elif orientation == direction.Spike:
			animation_player.play("SpikeDown")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await  get_tree().create_timer(2.5).timeout
	if anim_name == "SpikeUP":
		animation_player.play("SpikeDown")
	elif anim_name == "SpikeDown":
		animation_player.play("SpikeUP")
	pass # Replace with function body.
