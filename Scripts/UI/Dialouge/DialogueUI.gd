
class_name DialogueUI
extends CanvasLayer

@export_group("Text Animation")
@export var typing_speed: float = 35.0

@onready var root: Control = $Root

@onready var portrait: TextureRect = $Root/DialoguePanel/MarginContainer/VBoxContainer/HBoxContainer/CharacterPortrait

@onready var character_name: Label = $Root/DialoguePanel/MarginContainer/VBoxContainer/HBoxContainer/DialogueContent/CharacterName

@onready var dialogue_text: RichTextLabel = $Root/DialoguePanel/MarginContainer/VBoxContainer/HBoxContainer/DialogueContent/DialogueText

@onready var skip_button: Button = $Root/DialoguePanel/MarginContainer/VBoxContainer/ButtonContainer/SkipButton

var is_typing: bool = false
var typing_progress: float = 0.0


func _ready() -> void:
	root.hide()

	skip_button.pressed.connect(skip_typing)


func _process(delta: float) -> void:
	if not is_typing:
		return
		
	typing_progress += delta * typing_speed
	
	var total := dialogue_text.get_total_character_count()
	
	dialogue_text.visible_characters = min(
		int(typing_progress), total)
	if typing_progress >= total:
		is_typing = false
		dialogue_text.visible_characters = -1


func show_line(
	speaker: String,
	portrait_path: String,
	text: String
) -> void:
	
	print("Dialogue: ", text)
	print("Character count: ", dialogue_text.get_total_character_count())
	print("Dialogue size: ", dialogue_text.size)
	root.show()

	character_name.text = speaker
	dialogue_text.text = text

	# Load character portrait
	if portrait_path != "" and ResourceLoader.exists(portrait_path):
		portrait.texture = load(portrait_path) as Texture2D
	else:
		portrait.texture = null

	# Start typing animation
	typing_progress = 0.0
	dialogue_text.visible_characters = 0
	is_typing = true


func skip_typing() -> void:
	if not is_typing:
		return

	dialogue_text.visible_characters = -1
	is_typing = false


func hide_dialogue() -> void:
	root.hide()
	is_typing = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		show_line(
			"Old Man",
			"res://Assets/BG/Menu_BG.png",
            "Welcome, traveler! It has been a long time since someone visited this place."
		)
