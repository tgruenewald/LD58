extends Node2D
@onready var play: TextureButton = $ColorRect/HBoxContainer/Play
@onready var credits: TextureButton = $ColorRect2/MarginContainer/Credits
@onready var play_container: ColorRect = $ColorRect
@onready var credits_container: ColorRect = $ColorRect2
@onready var hbox: HBoxContainer = $ColorRect/HBoxContainer
@onready var margin: MarginContainer = $ColorRect2/MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Disable clipping on all containers so scaled buttons are visible
	play_container.clip_contents = false
	credits_container.clip_contents = false
	hbox.clip_contents = false
	margin.clip_contents = false
	
	# Set custom minimum size BEFORE scaling to force the button size
	play.custom_minimum_size = Vector2(320, 80)  # 128 * 2.5 = 320
	credits.custom_minimum_size = Vector2(320, 80)  # 128 * 2.5 = 320
	
	# Set stretch mode to scale
	play.stretch_mode = TextureButton.STRETCH_SCALE
	credits.stretch_mode = TextureButton.STRETCH_SCALE
	
	# Center the containers to center the buttons
	# Original Play position: -696, -200
	# Need to shift left by about half the extra width: (320-132)/2 = 94
	play_container.position = Vector2(-790, -200)
	
	# Original Credits position: -122, -207
	# Need to shift left by about half the extra width
	credits_container.position = Vector2(-216, -207)
	
	print("Play button custom_minimum_size: ", play.custom_minimum_size)
	print("Credits button custom_minimum_size: ", credits.custom_minimum_size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maintest.tscn")
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	pass # Replace with function body.
