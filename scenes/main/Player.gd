extends Node2D

var random_vector = Vector2()
var scope: Scope
var is_zoomed: bool = false

func _ready() -> void:
	scope = get_tree().get_first_node_in_group("scope")
	scope.scope_changed.connect(on_scope_changed)

func _process(delta: float) -> void:
	if is_zoomed:
		global_position = lerp(global_position, get_global_mouse_position(), 1.0 - exp(-2 * delta))
	else:
		global_position = lerp(global_position, get_global_mouse_position(), 1.0 - exp(-5 * delta))


func on_scope_changed():
	is_zoomed = !is_zoomed


func _on_scope_shoot() -> void:
	global_position.y += Vector2.UP.y * 300 * get_physics_process_delta_time()
	await get_tree().create_timer(0.1).timeout
	global_position.y += Vector2.DOWN.y * 100 * get_physics_process_delta_time()
