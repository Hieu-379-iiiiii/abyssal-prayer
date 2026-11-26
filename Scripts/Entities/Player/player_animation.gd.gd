class_name PlayerAnimation
extends Node

@export var player: Player
@export var sprite: AnimatedSprite2D

var _last_dir_suffix: String = "down"

func _ready() -> void:
	if player == null:
		player = get_parent() as Player

func _process(_delta: float) -> void:
	if player == null or sprite == null or sprite.sprite_frames == null:
		return

	var state_prefix := "Idle"
	if player.stats.is_dead:
		state_prefix = "Death"
	elif player.is_dashing:
		state_prefix = "Dash"
	elif player.velocity.length() > 1.0:
		state_prefix = "Walk"

	_update_facing(player.facing_direction)

	var anim_name := "%s-%s" % [state_prefix, _last_dir_suffix]
	if sprite.sprite_frames.has_animation(anim_name):
		if sprite.animation != anim_name or not sprite.is_playing():
			sprite.play(anim_name)
	elif sprite.sprite_frames.has_animation(state_prefix):
		if sprite.animation != state_prefix or not sprite.is_playing():
			sprite.play(state_prefix)

func _update_facing(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		return

	if abs(dir.x) > abs(dir.y):
		_last_dir_suffix = "left"
		sprite.flip_h = dir.x > 0.0
	else:
		sprite.flip_h = false
		_last_dir_suffix = "down" if dir.y >= 0.0 else "top"
