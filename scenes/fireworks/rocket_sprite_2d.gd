extends AnimatedSprite2D

@export var fireworks: Array[PackedScene]

var speed: float

func _ready() -> void:
	random_rocket_time()
	random_speed()
	$Timer.start()
	
func _physics_process(delta: float) -> void:
	position += Vector2.UP * speed

func _on_timer_timeout() -> void:
	var firework_instance = fireworks.pick_random().instantiate()
	firework_instance.global_position = global_position
	queue_free()
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)


func random_rocket_time():
	$Timer.wait_time = randf_range(1.0, 2.8)

func random_speed():
	speed = randf_range(2.0, 5.0)
	
