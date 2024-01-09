extends Area2D

@export var firework: Array[PackedScene]
@export var death_component: DeathComponent

var is_died = false
var time = 0.0
var speed: float
var freqency: float

func _ready() -> void:
	speed = randi_range(30, 50)
	freqency = randf_range(0.2, 2)
	if freqency == 0.0:
		randf_range(0.2, 2)
		
		
func _physics_process(delta: float) -> void:
	time += delta
	global_position += Vector2(speed * delta , sin(time * freqency) * 0.5)
	if global_position.x > 950:
		queue_free()
	
func explode():
	if is_died:
		return
	is_died = true
	set_deferred("monitorable", false)
	hide()
	var firework_instance = firework.pick_random().instantiate()
	firework_instance.global_position = global_position
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)
	if scale.x < 0.1:
		death_component.emit_signal("died")
	await firework_instance.animation_finished
	queue_free()
	


