class_name Player
extends Entity

@onready var stats: StatsComponent = $StatsComponent
@onready var inventory: InventoryComponent = $InventoryComponent
@onready var movement: PlayerMovement = $PlayerMovement


func _physics_process(delta: float) -> void:
	movement.physics_update(delta)
