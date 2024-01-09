extends Node2D

func _ready() -> void:
	var ufos = get_tree().get_nodes_in_group("ufo")
	for ufo in ufos:
		ufo.find_child("DeathComponent").died.connect(on_died)
		
		
func on_died():
	$CheerSoundPlayer.cheer()
