extends Node2D

@export var ufos: Array[PackedScene]
@export var rocket: PackedScene

var cheer_firework_count = 20
var game_score = 0

@onready var time_label: Label = %TimeLabel

func _ready() -> void:
	%BulletContainer.reload_sound_play.connect(on_reload)
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.stop()
	%Warning.hide()
	$CheerSoundPlayer.stop()
	$CountdownTimer.start()


func _process(delta: float) -> void:
	time_label.text = format_seconds_string($CountdownTimer.time_left)

func spawn_ufo():
	var ufo = ufos.pick_random().instantiate()
	var size = randf_range(0.03, 0.2)
	%UFOPathFollow2D.progress_ratio = randf()
	ufo.global_position = %UFOPathFollow2D.global_position
	ufo.scale = Vector2(size, size)
	ufo.find_child("DeathComponent").died.connect(on_died)
	ufo.score_calculated.connect(on_score_calculated)
	add_child(ufo)

func spawn_firework():
	var rocket_instance = rocket.instantiate()
	%FireworkPathFollow2D.progress_ratio = randf()
	rocket_instance.global_position = %FireworkPathFollow2D.global_position
	add_child(rocket_instance)


func format_seconds_string(seconds: float) -> String:
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + "%02d" % floor(remaining_seconds)


func on_died():
	cheer_firework_count = randi_range(10,15)
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


func _on_countdown_timer_timeout() -> void:
	$UFOSpawnTimer.stop()
	for ufo in get_tree().get_nodes_in_group("ufo"):
		ufo.queue_free()
	cheer_firework_count = randi_range(10,15)
	%EndScreen.update_score(game_score)
	%EndScreen.show()
	$CheerSoundPlayer.cheer()
	$FireworkTimer.start()
	

func on_score_calculated(score: int):
	game_score += score
	print(game_score)
