class_name Scope
extends Node2D

signal scope_changed
signal shoot
signal bullet_count_changed(bullet_count: int)
signal reload_bullet(bullet_count: int)

@export var scope_color: Color

var is_zoomed: bool = false
var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
var bullet_count = 6
var can_shoot = true
var can_reload = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	GameManager.can_shoot.connect(reload_completed)
		
		
func _process(delta: float) -> void:
		
	if Input.is_action_just_pressed("shoot") and can_shoot:
		if bullet_count == 0:
			reload()
			return
		bullet_count -= 1
		bullet_count_changed.emit(bullet_count)
		$AudioStreamPlayer2D.play()
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.global_position = global_position
		get_tree().root.add_child(bullet_instance)
		shoot.emit()
		
	if Input.is_action_just_pressed("reload") and can_reload:
		reload()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		animation_player.stop()
		toggle_scope()
	if event.is_action_pressed("ui_cancel"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		
		
func toggle_scope():
	scope_changed.emit()
	is_zoomed = !is_zoomed


func reload():
	can_shoot = false
	can_reload = false
	reload_bullet.emit(bullet_count)

func reload_completed():
	bullet_count = 6
	can_shoot = true
	can_reload = true
