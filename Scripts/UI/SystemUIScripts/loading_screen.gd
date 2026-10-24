extends  CanvasLayer

signal loading_screen_ready

@export var animation_player: AnimationPlayer
@export var progress_bar: ProgressBar

func _ready() -> void:
	animation_player.play("transistion") 
	await animation_player.animation_finished
	loading_screen_ready.emit()
	
func _on_progress_changed(new_value: float) -> void:
	progress_bar.value = new_value * 100.0
	
func _on_load_finished() -> void:
	animation_player.play_backwards("transistion")
	await animation_player.animation_finished
	queue_free()
