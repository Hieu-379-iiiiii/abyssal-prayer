extends CanvasLayer

var player: Player

@onready var health_bar: ProgressBar = $HUD/HealthBar
@onready var stamina_bar: ProgressBar = $HUD/StaminaBar


func set_player(new_player: Player) -> void:
	if health_bar == null or stamina_bar == null:
		push_error("PlayerHUD: Health or stamina bar not found!")
		return
	
	# Disconnect previous player.
	if player != null and is_instance_valid(player):
		var old_stats = player.stats
		
		if old_stats.health_changed.is_connected(_on_health_changed):
			old_stats.health_changed.disconnect(_on_health_changed)
			
			if old_stats.stamina_changed.is_connected(_on_stamina_changed):
				old_stats.stamina_changed.disconnect(_on_stamina_changed)
	
	player = new_player
	
	var stats = player.stats
	
	# Connect signals.
	stats.health_changed.connect(_on_health_changed)
	stats.stamina_changed.connect(_on_stamina_changed)
	
	# Initialize UI using current values and dynamic max values.
	_on_health_changed(stats.current_health, stats.current_max_health)
	_on_stamina_changed(stats.current_stamina, stats.current_max_stamina)


func _on_health_changed(current: float, maximum: float) -> void:
	update_health(current, maximum)


func _on_stamina_changed(current: float, maximum: float) -> void:
	update_stamina(current, maximum)


func update_health(current: float, maximum: float) -> void:
	health_bar.max_value = maximum
	health_bar.value = current


func update_stamina(current: float, maximum: float) -> void:
	stamina_bar.max_value = maximum
	stamina_bar.value = current
