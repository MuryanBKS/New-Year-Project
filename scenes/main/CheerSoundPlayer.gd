extends AudioStreamPlayer

@export var sound: Array[AudioStreamMP3]

var is_fade_out = false

func random_sound():
	stream = sound.pick_random()

func random_pitch():
	pitch_scale = randf_range(0.8, 1.2)

func cheer():
	volume_db = randf_range(-5.0, 0.0)
	random_sound()
	random_pitch()
	play()
	
