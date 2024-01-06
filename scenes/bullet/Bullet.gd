extends Area2D


func _on_timer_timeout() -> void:
	var targets = get_overlapping_areas()
	for target in targets:
		if target.has_method("explode"):
			target.explode()
	queue_free()
