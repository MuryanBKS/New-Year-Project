extends SubViewport

@onready var camera_2d: Camera2D = $Camera2D


func _process(delta: float) -> void:
	camera_2d.position = get_tree().get_first_node_in_group("scope").position
