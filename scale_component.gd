class_name ScaleComponent
extends Node2D

@export var sprite: Sprite2D
@export var normal_scale: Vector2 = Vector2(0.3, 0.3)
@export var zoomed_scale: Vector2 = Vector2(1.2, 1.2)

var scope: Scope
var is_zoomed: bool = false

func _ready() -> void:
	scope = get_tree().get_first_node_in_group("scope")
	scope.scope_changed.connect(on_scope_changed)
	sprite.scale = normal_scale

func toggle_scope():
	if is_zoomed:
		sprite.scale = normal_scale
		is_zoomed = !is_zoomed
	else:
		sprite.scale = zoomed_scale
		is_zoomed = !is_zoomed

func on_scope_changed():
	toggle_scope()
