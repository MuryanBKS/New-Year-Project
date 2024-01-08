extends Area2D

@export var firework: PackedScene

var is_died = false
var time = 0.0

func _physics_process(delta: float) -> void:
	time += delta
	global_position += Vector2(30 * delta , sin(time / 2) * 0.5)
	
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
	
