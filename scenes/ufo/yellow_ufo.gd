extends Area2D

@export var firework: PackedScene

var is_died = false

func _physics_process(delta: float) -> void:
	position += 25 * Vector2.RIGHT * delta

func explode():
	if is_died:
		return
	is_died = true
	set_deferred("monitorable", false)
	hide()
	var firework_instance = firework.instantiate()
	firework_instance.global_position = global_position
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)
	await firework_instance.animation_finished
	queue_free()
	
