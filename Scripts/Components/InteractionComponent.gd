
class_name InteractionComponent
extends Area2D

@export var dialogue_id: String = ""

@onready var prompt: Control = $InteractionPrompt

var player_in_range: bool = false


func _ready() -> void:
	prompt.hide()

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	player_in_range = true
	prompt.show()


func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	player_in_range = false
	prompt.hide()


func _unhandled_input(event: InputEvent) -> void:
	if not player_in_range:
		return

	if event.is_action_pressed("interact") and not event.is_echo():
		interact()
		get_viewport().set_input_as_handled()


func interact() -> void:
	print("Interacting with: ", dialogue_id)
