extends Node2D

signal can_shoot



func _ready() -> void:
	var bullet_container = get_tree().get_first_node_in_group("bullet_container")
	bullet_container.reload_completed.connect(_on_bullet_container_reload_completed)


func _on_bullet_container_reload_completed() -> void:
	can_shoot.emit()
