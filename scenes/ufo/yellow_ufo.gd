extends Area2D

@export var firework: Array[PackedScene]
@export var death_component: DeathComponent

var is_died = false
var speed: int

func _ready() -> void:
	speed = randi_range(50, 100)

func _physics_process(delta: float) -> void:
	position += speed * Vector2.RIGHT * delta
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
	

