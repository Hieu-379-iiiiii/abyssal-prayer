
extends Entity

@export_group("AI")
@export var target: Node2D
@export var detection_range: float = 500.0
@export var stop_distance: float = 30.0


func _physics_process(delta: float) -> void:

	if is_dead:
		return

	movement_direction = Vector2.ZERO

	if target != null:

		var distance = global_position.distance_to(
			target.global_position
		)

		if distance <= detection_range and distance > stop_distance:

			movement_direction = global_position.direction_to(
				target.global_position
			)

	# Use Entity's movement and stamina handling.
	super._physics_process(delta)
