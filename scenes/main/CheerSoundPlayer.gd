extends AudioStreamPlayer

@export var sound: Array[AudioStreamMP3]

var is_fade_out = false

func random_sound():
	stream = sound.pick_random()

func cheer():
	volume_db = randf_range(-10.0, -5.0)
	random_sound()
	play()
	
