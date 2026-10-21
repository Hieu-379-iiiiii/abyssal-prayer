extends Node

func _ready() -> void:
	var player_instance = GameManager.player_scene.instantiate()
	
	var spawn_pos = Vector2.ZERO
	
	player_instance.global_position = spawn_pos
	
	add_child(player_instance)
	
	#var spawn_pos = Vector2(0,0)
	#
	#player_instance.gloabl_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
