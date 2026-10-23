class_name Player
extends Entity

@onready var stats: StatsComponent = $StatsComponent
@onready var inventory: InventoryComponent = $InventoryComponent

@export_group("Dash")
@export var dash_speed: float = 850.0
@export var dash_duration: float = 0.15
@export var dash_cost: float = 25.0

var facing_direction: Vector2 = Vector2.DOWN
var is_dashing: bool = false

var dash_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:

	if stats.is_dead:
		velocity = Vector2.ZERO
		return

	if is_dashing:
		dash_timer -= delta

		velocity = dash_direction * dash_speed
		move_and_slide()

		if dash_timer <= 0:
			is_dashing = false

		return

	var input_direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)

	if input_direction != Vector2.ZERO:
		facing_direction = input_direction.normalized()

	velocity = input_direction * move_speed
	move_and_slide()

	if Input.is_action_just_pressed("ui_accept"):
		try_dash()


func try_dash() -> void:

	if is_dashing:
		return

	if not stats.consume_stamina(dash_cost):
		return

	is_dashing = true
	dash_timer = dash_duration
	dash_direction = facing_direction
