extends Node2D
@onready var play: TextureButton = $ColorRect/HBoxContainer/Play
@onready var credits: TextureButton = $ColorRect2/MarginContainer/Credits


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maintest.tscn")
	pass # Replace with function body.
