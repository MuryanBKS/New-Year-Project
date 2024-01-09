extends MarginContainer

signal reload_completed
signal reload_sound_play

@export var bullet_sprite: Array[Texture]
@export var bullet_texture: Array[TextureRect]


var scope: Scope


func _ready() -> void:
	scope = get_tree().get_first_node_in_group("scope")
	scope.bullet_count_changed.connect(update_bullet_ui)
	scope.reload_bullet.connect(on_reload)
	
	
func update_bullet_ui(bullet_count):
	for i in (6 - bullet_count):
		bullet_texture[5 - i].texture = bullet_sprite[1]


func on_reload(bullet_count):
	for i in (6 - bullet_count):
		reload_sound_play.emit()
		bullet_texture[i + bullet_count].texture = bullet_sprite[0]
		await get_tree().create_timer(.5).timeout
	reload_completed.emit()
