extends Camera2D

var scope: Area2D
var is_zoomed = false

func _ready() -> void:
	scope = get_tree().get_first_node_in_group("scope")
	scope.scope_changed.connect(on_scope_changed)
	
	
func _process(delta: float) -> void:
	if is_zoomed:
		zoom = lerp(zoom, Vector2(5, 5), 1.0 - exp(-delta))
		position = scope.position
	else:
		zoom = lerp(zoom, Vector2(1, 1), 1.0 - exp(-delta * 5))
		position = scope.position

func on_scope_changed():
	is_zoomed = !is_zoomed
