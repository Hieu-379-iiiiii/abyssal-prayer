extends Node

func _ready() -> void:
	var player_instance = GameManager.player_scene.instantiate()
	var player_hud : CanvasLayer = $"../PlayerHud"
	var spawn_pos = Vector2.ZERO
	
	player_instance.global_position = spawn_pos
	
	add_child(player_instance)
	
	player_hud.call_deferred("set_player", player_instance)
	
func _process(delta: float) -> void:
	pass
