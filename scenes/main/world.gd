extends Node2D

@export var ufos: Array[PackedScene]
@export var rocket: PackedScene
var cheer_firework_count = 20

func _ready() -> void:
	%BulletContainer.reload_sound_play.connect(on_reload)
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.stop()
	%Warning.hide()
	$CheerSoundPlayer.stop()
	
	
func spawn_ufo():
	var ufo = ufos.pick_random().instantiate()
	var size = randf_range(0.03, 0.2)
	%UFOPathFollow2D.progress_ratio = randf()
	ufo.global_position = %UFOPathFollow2D.global_position
	ufo.scale = Vector2(size, size)
	ufo.find_child("DeathComponent").died.connect(on_died)
	add_child(ufo)

func spawn_firework():
	var rocket_instance = rocket.instantiate()
	%FireworkPathFollow2D.progress_ratio = randf()
	rocket_instance.global_position = %FireworkPathFollow2D.global_position
	add_child(rocket_instance)

func on_died():
	cheer_firework_count = randi_range(15,20)
	$CheerSoundPlayer.cheer()
	$FireworkTimer.start()
	

func _on_spawn_timer_timeout() -> void:
	spawn_ufo()


func _on_firework_timer_timeout() -> void:
	cheer_firework_count -= 1
	spawn_firework()
	if cheer_firework_count == 0:
		$FireworkTimer.stop()

func on_reload():
	$ReloadSoundPlayer2D.play()
