extends CharacterBody2D
@onready var talk: RichTextLabel = $Talk
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var stop_right_there := false
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

var test_deni = "Deni:
You’re really going at it again?
After all of that?
Heh...
So naive.
I would’ve stopped the moment I realized how far you’d have to go to reach [wave]The Outside[/wave].
As a matter of fact... I have.
There is nothing beyond [wave]The Outside[/wave]for you.
Nothing but more pain and suffering.
Best to finish before you start."

var deni_speech = ["Deni:
You’re really going at it again?
After all of that?
Heh...
So naive.
I would’ve stopped the moment I realized how far you’d have to go to reach [color=purple]The Outside[/color].
As a matter of fact... I have.
There is nothing beyond The Outside for you.
Nothing but more pain and suffering.
Best to finish before you start.
",
"Deni:
Wow... how impressive!
You actually managed to make some progress!
Oh, how’d I get here?
Oh, I just used this neat little shortcut you completely missed along the way. 
Where is it?
Hah!
As if I’d tell you!
I couldn’t help but wonder how far you’d go after seeing you get through all that...
Your determination... it has started to amuse me.
it’s almost infectious in a way...
Well, that little dump wasn’t very interesting anyway.
Go on with your silly quest, don’t come crying to me when it truly fails!
",
"Deni:
.
.
.
"

]


var deni_dead_speech = [
	"Deni:
Back again?
No big surprise here! Your quite stubborn for a stupid cat!
Do you really think such a journey is worth the effort?
Worth going all the way to the top of your home?
Worth all the trouble just to answer an equally worthless question?
Deni:
.
.
.
You’ve got nothing?
Exactly.
",

"Deni:
Wow.
Another reset, another go, aye?
The concept of quitting must allude you.
It’s a pointless quest.
It is simply another maze to explore, an attempt at entertaining us within this “prison”.
Well... that’s what [color=purple]Ag[/color] called it.
It’s actually quite nice here.
No need to eat, no need to sleep...
No need to worry... no need to... starve... to...
Look, just stop climbing. 
You're just making a fool of yourself.
",

"Deni:
.
.
.
Deni:
Really now?
Your starting to push my patience.
I already told you what’s out there.
There’s no need to repeat what’s been told.
Deni:
.
.
.
Deni:
 
Well, I mean there could be something in [color=purple]The Outside[/color] that...
Deni:
...no.
That’s just wishful thinking.
Go on, keep failing.
I’ll wait.
",

"Deni:
Well you’ve long surpassed the third attempt.
I would’ve expected you to end it all there.
And yet... you keep pushing.
Is giving up not an option to you?
Can it please be one?
I’d really like to have some company in this... “prison”...
Is it really a prison or... Nevermind.
Just give in and go back home.
",

"Deni:
AGAIN?!
How determined are you.
HOW ARE YOU 

Deni:
Sorry, let me recompose myself.
Do you even remember what I previously said?
There is [i]nothing[/i] beyond [color=purple]The Outside[/color], and there never will be.
How hard is it to listen to your superiors?
Do I have to beat you like [color=purple]THEY[/color] did to listen?
I’m... I’m done with you.
Just...
Just reconsider...
",

"Deni:
Look, I know you’ve made it far.
It’s impressive, yes, but are you sure that this is worth it?
Are you COMPLETELY sure?
You know what happened last time we left the box... it could happen again...
Actually, no it won’t.
That was a miracle!
Miracles only happen once!
Miracles only happen... Maybe again?
... no... it can’t...
",

"Deni:
I can see it in your eyes... your still not stopping, are you?
I really thought it was out of boredom at first... maybe spite or malice... but after thinking about it for a bit...
Nah, it couldn’t be him!
We haven’t seen him in weeks!
But... maybe...
",

"Deni:
Still feeling like climbing?
I mean... I can’t blame you... I should be blaming whoever put us here in the first place.
Actually, who did put us here?
To be honest... I don’t really remember...
Eh.
We probably just got in here for fun!
Boxes are fun!
Really fun!
Yeah!
Yeah...
",

"Deni:
Look... I...
I think we got off on the wrong foot.
I didn’t mean to be so harsh!
I just was being a little skeptical, ok?
You were making the same mistake I was when I first woke up in here!
I simply couldn’t let you continue without a warning...
Wait, was [i]I[/i] the one in the wrong?
No, it was you!
Still you!
",

"Deni:
Just... please... just...
Reconsider.
Deni:
 
I... I don’t want to feel alone... please, I...
Deni:
.
.
.
"
]


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
	if Input.is_action_just_pressed("interact") and Neu_is_here or stop_right_there:
		var dialogue_node = dialogue_scene.instantiate()
		get_tree().root.add_child(dialogue_node)
		GameManager.playable_character.motion_paused = true
		match alternate_neu_name:
			neu_name.Deni:
				# First Speech
				print(GameManager.level_1_half_way)
				print(GameManager.deni_speech_num)
				if GameManager.deni_speech_num < GameManager.deni_speech_max and not GameManager.just_died and not GameManager.level_1_half_way:
					print("first speech")
					dialogue_node._generate_dialogue_box(deni_speech[GameManager.deni_speech_num])
					GameManager.deni_speech_num += 1
					
				# Second half Speech
				elif GameManager.deni_speech_num <= GameManager.deni_speech_max and not GameManager.just_died and GameManager.level_1_half_way:
					print("second speech")
					dialogue_node._generate_dialogue_box(deni_speech[GameManager.deni_speech_num])
					GameManager.deni_speech_num += 1
				
				# Nothing extra to say
				else:
					if not stop_right_there:
						dialogue_node._generate_dialogue_box(deni_speech[2])
					
			neu_name.Ag:
				pass
			neu_name.Gai:
				pass
			neu_name.Ress:
				pass
		stop_right_there = false
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
			if not GameManager.level_1_half_way and GameManager.deni_speech_num == 0:
				stop_right_there = true
			elif GameManager.level_1_half_way and GameManager.deni_speech_num == 1:
				stop_right_there = true
	pass # Replace with function body.


func _play_dead_message():
	print(1)
	print(GameManager.level_1_half_way)
	print(GameManager.just_died)
	if not GameManager.level_1_half_way and GameManager.just_died:
		print(2)
		#GameManager.just_died = false
		match alternate_neu_name:
			neu_name.Deni:
				if GameManager.deni_dead_speech_num < 5:
					print(3)
					var dialogue_node = dialogue_scene.instantiate()
					get_tree().root.add_child(dialogue_node)
					GameManager.playable_character.motion_paused = true
					dialogue_node._generate_dialogue_box(deni_dead_speech[GameManager.deni_dead_speech_num])
					GameManager.deni_dead_speech_num += 1
				pass
			neu_name.Ag:
				pass
			neu_name.Gai:
				pass
			neu_name.Ress:
				pass
			neu_name.Mystery:
				pass
		pass
	elif GameManager.level_1_half_way and GameManager.just_died:
		#GameManager.just_died = false
		match alternate_neu_name:
			neu_name.Deni:
				if GameManager.deni_dead_speech_num < 10:
					var dialogue_node = dialogue_scene.instantiate()
					get_tree().root.add_child(dialogue_node)
					GameManager.playable_character.motion_paused = true
					dialogue_node._generate_dialogue_box(deni_dead_speech[GameManager.deni_dead_speech_num])
					GameManager.deni_dead_speech_num += 1
				pass
		pass
	pass
