extends Node2D

@onready var wallet: Label = $CanvasLayer/Wallet
@onready var play: TextureButton = $CanvasLayer/ColorRect/MarginContainer/Play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wallet.text = "$ " +  str(Master.getWallet())


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maintest.tscn")
	pass # Replace with function body.


func _on_more_time_pressed() -> void:
	if Master.getWallet() >= 200:
		Master.spend(200)
		Master.timeAdd += 20
	pass # Replace with function body.


func _on_double_jump_pressed() -> void:
	if Master.getWallet() >= 1000:
		Master.spend(1000)
		Master.jumpAdd += 1
	pass # Replace with function body.
