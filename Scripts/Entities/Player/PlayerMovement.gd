class_name PlayerMovement
extends Node

@export var player: Player

@export_group("Dash")
@export var dash_speed: float = 600
@export var dash_duration: float = 0.2
@export var dash_cost: float = 25.0

var facing_direction: Vector2 = Vector2.DOWN
var is_dashing: bool = false

var dash_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	if player == null:
		player = get_parent() as Player


func physics_update(delta: float) -> void:
	if player == null:
		return

	if player.stats.is_dead:
		player.velocity = Vector2.ZERO
		return

	if is_dashing:
		_process_dash(delta)
		return

	_process_movement()

	if Input.is_action_just_pressed("ui_accept"):
		try_dash()


func _process_movement() -> void:
	var input_direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)

	if input_direction != Vector2.ZERO:
		facing_direction = input_direction.normalized()

	player.velocity = input_direction * player.move_speed
	player.move_and_slide()


func _process_dash(delta: float) -> void:
	dash_timer -= delta

	player.velocity = dash_direction * dash_speed
	player.move_and_slide()

	if dash_timer <= 0.0:
		is_dashing = false


func try_dash() -> void:
	if is_dashing:
		return

	if not player.stats.consume_stamina(dash_cost):
		return

	is_dashing = true
	dash_timer = dash_duration
	dash_direction = facing_direction
