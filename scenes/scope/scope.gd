class_name Scope
extends Node2D

signal scope_changed
signal shoot

@export var scope_color: Color

var is_zoomed: bool = false
var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
var breath_effect = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	
	if (global_position - get_global_mouse_position()).length() < 20.0 and breath_effect and is_zoomed:
		animation_player.queue("idle")
		
	if Input.is_action_just_pressed("shoot"):
		$AudioStreamPlayer2D.play()
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.global_position = global_position
		get_tree().root.add_child(bullet_instance)
		shoot.emit()

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		animation_player.stop()
		toggle_scope()
	if event.is_action_pressed("ui_cancel"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		
		
func toggle_scope():
	scope_changed.emit()
	is_zoomed = !is_zoomed
	breath_effect = !breath_effect
