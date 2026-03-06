extends Node2D
@onready var speaker_name: RichTextLabel = $"Paper/Speaker Name"
@onready var dialogue: RichTextLabel = $Paper/Dialogue
@onready var cat_portraits: Node2D = $"Cat Portraits"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


enum dialogue_status {
	READY,
	ANIMATING,
	SPEEDING
	}
	
var pitch_random: float
var dialogue_state = dialogue_status.READY
var time_interval:= 0.05
var speaking_turn: int = 0
var bite_number: int = 0
var dialogue_is_ready:= false
var current_character: int = 0
var dialogue_bites: String
var current_speaker: String
var dialogue_array: Array  #[ [current speaker, [bite, nth bite]] ]
var temporary_string: String = ""
var testing: String = "hello
 world"
var test_script: String = "
Neu:
This is a new sentence.
And so is this one.
What the?
Hello.
Aim and shoot fireball on duct tape that prevents an object from moving, said object can be stopped to be used as a platform with paralyze.
Upon reaching Bargaining Neu, he offers a bargain to hear what you have to say only if you can win his minigame.
Minigame entails guessing which Bargaining Neu is the real one by casting fireball on the right one.
He will create a number of duplicates and run around the level. 
There will be multiple rounds and in each next round the number of Illusion Neu increases.
Upon finishing the minigame, have a talk with Bargaining Neu to absorb him.

Denial Neu:
Using The duplicate Illusion ability, safely find a way past fake platforms and for pressure plate purposes.
Reaching Depression Neu and absorbing him will give you the ability over the rain, clearing it to reveal a clear sky and end the game.

Neu:
Stunning objects in order to move on top of it as a platform or from falling.
For example, a bridge where you have to stun a falling ball from above.
Upon reaching Anger Neu, he is setting things on fire and the player is in a minigame to reach those fires to put the out.
Victory & chance to talk to Anger Neu upon putting all fires out.
However Anger Neu could reignite them at any time, the player can use Paralyze/stun on Anger Neu to delay this.
"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(testing.length())
	#_generate_dialogue_box(test_script)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogue_is_ready and (Input.is_action_just_pressed("Left Click") or Input.is_action_just_pressed("Jump")) and dialogue_state == dialogue_status.READY:
		next_dialogue()
	elif dialogue_is_ready and (Input.is_action_just_pressed("Left Click") or Input.is_action_just_pressed("Jump")) and dialogue_state == dialogue_status.ANIMATING:
		dialogue_state = dialogue_status.SPEEDING
		time_interval = 0.0025
		pass
	pass

func _generate_dialogue_box(script:String) -> void:
	for i in script:
		#print(i)
		if i == "\n":
			match temporary_string:
				"Neu:":
					current_speaker = "Neu"
					dialogue_array.append([current_speaker, []])
				"Denial Neu:":
					current_speaker = "Denial Neu"
					dialogue_array.append([current_speaker, []])
				"Anger Neu:":
					current_speaker = "Anger Neu"
					dialogue_array.append([current_speaker, []])
				"Bargaining Neu:":
					current_speaker = "Bargaining Neu"
					dialogue_array.append([current_speaker, []])
				"Depression Neu:":
					current_speaker = "Depression Neu"
					dialogue_array.append([current_speaker, []])
				_:
					if temporary_string != "":
						#if sentence under 110 character, become 1 bite, if more becomes 2
						var current_word: String
						for ab in temporary_string:
							if ab == " ":
								if dialogue_bites.length() + current_word.length() <= 110:
									#print(dialogue_bites)
									if dialogue_bites.length() == 0:
										dialogue_bites += current_word
									else:
										dialogue_bites += " " + current_word
									pass
								else:
									#print(dialogue_bites)
									dialogue_bites += "-"
									dialogue_array[dialogue_array.size()-1][1].append(dialogue_bites)
									dialogue_bites = current_word
								current_word = ""
							elif ab[ab.length()-1] == "." or ab[ab.length()-1] == "?" or ab[ab.length()-1] == "!":
								dialogue_bites += " " + current_word + ab[ab.length()-1]
								current_word = ""
							else:
								#print(ab)
								current_word += ab
								
						dialogue_array[dialogue_array.size()-1][1].append(dialogue_bites)
						dialogue_bites = current_word
						
			temporary_string = ""
			pass
		else:
			temporary_string += i
			#print(temporary_string)
	# check name
	print(dialogue_array)
	print(dialogue_array.size())
	
	# Combines any 2 sentences, current & next sentence from the same character speaking turn 
	# so long as its under 110 total words and no dash "-" in the current sentence
	for i in dialogue_array:
		var max_bite_count: int = i[1].size()-1
		var bite_count: int = 0
		var checking:= true
		while checking:
			print("bite count = ", bite_count)
			if bite_count != max_bite_count:
				if (i[1][bite_count] + i[1][bite_count+1]).length() <= 110 and bite_count > 0:
					if i[1][bite_count-1][i[1][bite_count-1].length()-1] != "-":
						i[1][bite_count] += " " + i[1][bite_count+1]
						i[1].remove_at(bite_count+1)
						max_bite_count -= 1
						bite_count-=1
						pass
				elif (i[1][bite_count] + i[1][bite_count+1]).length() <= 110:
					i[1][bite_count] += " " + i[1][bite_count+1]
					i[1].remove_at(bite_count+1)
					max_bite_count -= 1
					bite_count-=1
					pass
			bite_count+=1
			if bite_count == max_bite_count:
				checking = false
			pass
	print(dialogue_array)
		
	#Showcase first dialogue/bite
	next_dialogue()
	#speaker_name.text = dialogue_array[0][0]
	#dialogue.text = dialogue_array[0][1][0]
	
	#dialogue_is_ready = true
		
	pass

#animate the showing of dialogue
func next_dialogue():
	print(time_interval)
	dialogue_is_ready = true
	dialogue_state = dialogue_status.ANIMATING
	if bite_number > dialogue_array[speaking_turn][1].size()-1:
		bite_number = 0
		speaking_turn += 1
	if speaking_turn > dialogue_array.size()-1:
		if GameManager.playable_character != null:
			GameManager.playable_character.motion_paused = false
		queue_free()
	else:
		dialogue.text = ""
		for i in cat_portraits.get_children():
			if i.name == dialogue_array[speaking_turn][0]:
				i.visible = true
			else:
				i.visible = false
		speaker_name.text = "[wave]" + dialogue_array[speaking_turn][0] + "[/wave]"
		for i in dialogue_array[speaking_turn][1][bite_number]:
			if i == "," or i == ".":
				time_interval *= 8
			dialogue.text += i
			await get_tree().create_timer(time_interval, false, true,false).timeout
			if i == "," or i == ".":
				time_interval /= 8
			if i not in ["!", "?", ",", ".", " ", "-"]:
				pitch_random = randf_range(0.9,1.1)
				if i in ["a", "e", "i", "o", "u"]:
					pitch_random += 0.2
				play_audio()
				pass
			
			
		#dialogue.text = dialogue_array[speaking_turn][1][bite_number]
		bite_number += 1 
		dialogue_state = dialogue_status.READY
		time_interval = 0.05
	pass

func play_audio():
	var new_audio = audio_stream_player.duplicate()
	get_tree().root.add_child(new_audio)
	new_audio.pitch_scale = pitch_random
	new_audio.play()
	await get_tree().create_timer(time_interval*4, false, true,false).timeout
	#await new_audio.finished
	new_audio.queue_free()
	pass
