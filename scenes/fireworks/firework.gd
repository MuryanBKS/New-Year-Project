extends AnimatedSprite2D

var size: float

func _ready() -> void:
	random_size()
	random_pitch()
	random_volume()
	
	play("default")
	$AudioStreamPlayer2D.play()

func _on_animation_finished() -> void:
	queue_free()

func random_size():
	size = randf_range(1.0, 2.0)
	scale = Vector2(size, size)
	
	
func random_pitch():
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.7, 1.2)
	
	
func random_volume():
	$AudioStreamPlayer2D.volume_db = randf_range(-5.0, 0.0)
	
