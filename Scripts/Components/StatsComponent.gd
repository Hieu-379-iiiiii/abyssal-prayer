class_name StatsComponent
extends Node

signal health_changed(current: float, maximum: float)
signal stamina_changed(current: float, maximum: float)
signal died

@export_group("Health")
@export var max_health: float = 100.0

@export_group("Stamina")
@export var max_stamina: float = 100.0
@export var stamina_regen: float = 20.0

var current_health: float
var current_stamina: float

var is_dead: bool = false


func _ready() -> void:
	current_health = max_health
	current_stamina = max_stamina
	
	health_changed.emit(current_health, max_health)
	stamina_changed.emit(current_stamina, max_stamina)


func _process(delta: float) -> void:
	regenerate_stamina(delta)
# HEALTH

func take_damage(amount: float) -> void:
	if is_dead or amount <= 0:
		return

	current_health = maxf(current_health - amount, 0.0)

	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		is_dead = true
		died.emit()


func heal(amount: float) -> void:
	if is_dead or amount <= 0:
		return

	current_health = minf(current_health + amount, max_health)

	health_changed.emit(current_health, max_health)


# STAMINA

func consume_stamina(amount: float) -> bool:
	if is_dead or amount < 0:
		return false

	if current_stamina < amount:
		return false

	current_stamina -= amount
	stamina_changed.emit(current_stamina, max_stamina)

	return true


func regenerate_stamina(delta: float) -> void:
	if is_dead:
		return

	if current_stamina >= max_stamina:
		return

	current_stamina = minf(
	current_stamina + stamina_regen * delta,
	max_stamina
	)

	stamina_changed.emit(current_stamina, max_stamina)
