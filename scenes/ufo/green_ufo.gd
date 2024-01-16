extends Area2D

signal score_calculated(score)

@export var firework: Array[PackedScene]
@export var death_component: DeathComponent

var is_died = false
var move_time = 0.0
var speed_forward: float
var speed_backward: float
var score = 50
var is_move_forward = true

func _ready() -> void:
	speed_forward = randi_range(30, 60)
	speed_backward = randi_range(-80, -150)
	move_time = randf_range(3, 5)
	$Timer.wait_time = move_time
	var tween = create_tween()
	tween.tween_property(self, "rotation", 0.3, move_time).set_trans(Tween.TRANS_CUBIC)
	$Timer.start()
	
func _physics_process(delta: float) -> void:
	if is_move_forward:
		global_position.x += speed_forward * Vector2.RIGHT.x * delta
		global_position.y += 15 * Vector2.UP.y * delta
		
	else :
		global_position.x += speed_backward * Vector2.RIGHT.x * delta
		global_position.y += -30 * Vector2.UP.y * delta
		
	if global_position.x > 950:
		queue_free()
	
func explode():
	if is_died:
		return
	is_died = true
	set_deferred("monitorable", false)
	hide()
	score = score * ((speed_forward - speed_backward) / 2) *  roundi(1 / scale.x)
	score_calculated.emit(score)
	var firework_instance = firework.pick_random().instantiate()
	firework_instance.global_position = global_position
	get_tree().get_first_node_in_group("fireworks").add_child(firework_instance)
	if scale.x < 0.1:
		death_component.emit_signal("died")
	await firework_instance.animation_finished
	
	queue_free()
	

func _on_timer_timeout() -> void:
	if is_move_forward:
		move_time = randf_range(0.2, 0.8)
		var tween = create_tween()
		tween.tween_property(self, "rotation", -0.5, move_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		$Timer.wait_time = move_time
		speed_backward = randi_range(-80, -150)
		$Timer.start()
	else:
		move_time = randf_range(1, 3)
		var tween = create_tween()
		tween.tween_property(self, "rotation", 0.3, move_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		$Timer.wait_time = move_time
		speed_forward = randi_range(30, 60)
		$Timer.start()
		
	is_move_forward = !is_move_forward
