class_name ScopeComponent
extends Node2D

@export var animation_player: AnimationPlayer

var scope: Scope
var is_zoomed: bool = false

func _ready() -> void:
	scope = get_tree().get_first_node_in_group("scope")
	scope.scope_changed.connect(on_scope_changed)

func toggle_scope():
	if is_zoomed:
		animation_player.queue("zoom_out")
		is_zoomed = !is_zoomed
	else:
		animation_player.queue("zoom_in")
		is_zoomed = !is_zoomed

func on_scope_changed():
	toggle_scope()
