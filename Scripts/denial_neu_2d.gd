extends CharacterBody2D
@onready var talk: RichTextLabel = $Talk
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var Neu_is_here:= false
var dialogue_scene = preload("res://Scenes/dialogue_system.tscn") 
enum neu_name {
	Neu,
	Deni,
	Ag,
	Gai,
	Ress,
	Mystery
}
@export var alternate_neu_name: neu_name

var mystery_dialogue = "Unknown Narrator:
So… your attempting the climb again.
I see… You have tried before.
You have failed before.
Yet… you go on.
You know damn well that this is no easy task.
You know it’s easy to just give up and call it quits.
But you haven’t.
…
A crossroads lays ahead of you. 
Only you know where to go next, Neu.
And I trust you’ll pick the right choice.
Good luck… You’ll need it.
"

func _ready() -> void:
	talk.visible = false
	match alternate_neu_name:
		neu_name.Neu:
			pass
		neu_name.Deni:
			animated_sprite_2d.play("Deni Idle")
		neu_name.Ag:
			animated_sprite_2d.play("Ag Idle")
		neu_name.Gai:
			animated_sprite_2d.play("Gai Idle")
		neu_name.Ress:
			animated_sprite_2d.play("Ress Idle")
		neu_name.Mystery:
			animated_sprite_2d.play("Mystery Idle")
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Neu_is_here:
		var dialogue_node = dialogue_scene.instantiate()
		get_tree().root.add_child(dialogue_node)
		dialogue_node._generate_dialogue_box(dialogue_node.test_script)
		GameManager.playable_character.motion_paused = true
	move_and_slide()



func _on_dialogue_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = true
			talk.visible = true
	pass # Replace with function body.


func _on_dialogue_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get_collision_layer_value(2) == true:
			Neu_is_here = false
			talk.visible = false
	pass # Replace with function body.
