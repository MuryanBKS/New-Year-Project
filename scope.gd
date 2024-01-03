class_name Scope
extends Area2D

signal scope_changed

var is_zoomed: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	queue_redraw()

func _draw() -> void:
	if is_zoomed:
		draw_circle(Vector2(), 2, Color.FIREBRICK)
	if not is_zoomed:
		draw_line(Vector2(0, 40),Vector2(0, -40), Color.FIREBRICK)
		draw_line(Vector2(40, 0),Vector2(-40, 0), Color.FIREBRICK)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not animation_player.is_playing():
		toggle_scope()
	if event.is_action_pressed("ui_cancel"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func toggle_scope():
	scope_changed.emit()
	is_zoomed = !is_zoomed
