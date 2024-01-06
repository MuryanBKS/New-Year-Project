extends Area2D

var firework = preload("res://scenes/fireworks/firework_blue.tscn")

func explode():
	hide()
	var firework_instance = firework.instantiate()
	firework_instance.global_position = global_position
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)
	await firework_instance.animation_finished
	queue_free()
	
