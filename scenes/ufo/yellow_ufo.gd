extends Area2D

signal score_calculated(score)

@export var firework: Array[PackedScene]
@export var death_component: DeathComponent

var is_died = false
var speed: int
var score = 10

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
	score = score * speed *  roundi(1 / scale.x)
	score_calculated.emit(score)
	var firework_instance = firework.pick_random().instantiate()
	firework_instance.global_position = global_position
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)
	if scale.x < 0.1:
		death_component.emit_signal("died")
	await firework_instance.animation_finished
	queue_free()
	

