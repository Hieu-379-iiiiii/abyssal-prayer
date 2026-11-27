extends Node

func _ready() -> void:
	var player_instance = GameManager.player_scene.instantiate()

	get_parent().add_child.call_deferred(player_instance)
	player_instance.set_deferred("global_position", Vector2.ZERO)
	
	var player_hud := get_node_or_null("../PlayerHud") as CanvasLayer
	if player_hud:
		player_hud.call_deferred("set_player", player_instance)
