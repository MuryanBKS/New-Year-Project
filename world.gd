extends Node2D

var firework = preload("res://firework_blue.tscn")



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		var firework_instance = firework.instantiate()
		firework_instance.global_position = get_global_mouse_position()
		add_child(firework_instance)
		
