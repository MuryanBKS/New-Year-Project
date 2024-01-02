extends Sprite2D

var normal_scale: Vector2 = Vector2(0.3, 0.3)
var zoomed_scale: Vector2 = Vector2(1.2, 1.2)
var is_zoomed: bool = false

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	scale = normal_scale

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _draw() -> void:
	draw_circle(Vector2(), 10, Color.FIREBRICK)
	draw_circle_arc(Vector2(), 410, 0, 360, Color.DARK_SLATE_BLUE)


func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		toggle_scope()
	if event.is_action_pressed("ui_cancel"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func toggle_scope():
	if is_zoomed:
		scale = normal_scale
		is_zoomed = !is_zoomed
	else:
		scale = zoomed_scale
		is_zoomed = !is_zoomed
