extends Area2D


func _on_timer_timeout() -> void:
	var targets = get_overlapping_areas()
	print(targets)
	#for target in targets:
		#target.explode()
