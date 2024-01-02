class_name Scope
extends Area2D

signal scope_changed

var is_zoomed: bool = false

@onready var color_rect: ColorRect = %ColorRect2
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	color_rect.hide()

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	camera_2d.position = position

func _draw() -> void:
	draw_circle(Vector2(), 5, Color.FIREBRICK)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		toggle_scope()
	if event.is_action_pressed("ui_cancel"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func toggle_scope():
	scope_changed.emit()
	if is_zoomed:
		color_rect.hide()
		is_zoomed = !is_zoomed
	else:
		color_rect.show()
		is_zoomed = !is_zoomed

	
