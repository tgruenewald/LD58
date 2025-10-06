extends Node2D

@onready var wallet: Label = $CanvasLayer/Wallet
@onready var play: TextureButton = $CanvasLayer/ColorRect/MarginContainer/Play
@onready var moreTime: TextureButton = $CanvasLayer/ColorRect2/MarginContainer/moreTime
@onready var doubleJump: TextureButton = $CanvasLayer/ColorRect3/MarginContainer/DoubleJump
@onready var wallJump: TextureButton = $CanvasLayer/ColorRect4/MarginContainer/WallJump
@onready var magnet: TextureButton = $CanvasLayer/ColorRect5/MarginContainer/Magnet

var i_key_was_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wallet.text = "$ " +  str(Master.getWallet())
	
	# Debug: Press 'x' to add 10 points for testing
	if Input.is_physical_key_pressed(KEY_X):
		if not i_key_was_pressed:
			Master.wallet += 100
			print("Debug: Added 10 points. Total: ", Master.getWallet())
			i_key_was_pressed = true
	else:
		i_key_was_pressed = false
	
	# Add hover effects to shelf buttons
	if moreTime.is_hovered():
		moreTime.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		moreTime.modulate = Color(1, 1, 1, 1)
		
	if doubleJump.is_hovered():
		doubleJump.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		doubleJump.modulate = Color(1, 1, 1, 1)
		
	if wallJump.is_hovered():
		wallJump.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		wallJump.modulate = Color(1, 1, 1, 1)
		
	if magnet.is_hovered():
		magnet.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		magnet.modulate = Color(1, 1, 1, 1)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maintest.tscn")
	pass # Replace with function body.


func _on_more_time_pressed() -> void:
	if Master.getWallet() >= 100:
		Master.spend(100)
		Master.timeAdd += 15
		print("Purchased More Time! Added 15 seconds. Total time bonus: ", Master.timeAdd)
	else:
		print("Not enough money for More Time! Need $100, have $", Master.getWallet())
	pass # Replace with function body.


func _on_double_jump_pressed() -> void:
	if Master.getWallet() >= 1000:
		Master.spend(1000)
		Master.jumpAdd += 1
		print("Purchased Double Jump! Added extra jump. Total jumps: ", Master.jumpAdd + 1)
	else:
		print("Not enough money for Double Jump! Need $1000, have $", Master.getWallet())
	pass # Replace with function body.


func _on_wall_jump_pressed() -> void:
	if Master.getWallet() >= 1000:
		Master.spend(1000)
		Master.wallJump = true
		print("Purchased Wall Jump! Wall jumping is now enabled!")
	else:
		print("Not enough money for Wall Jump! Need $1000, have $", Master.getWallet())
	pass # Replace with function body.


func _on_magnet_pressed() -> void:
	if Master.getWallet() >= 500:
		Master.spend(500)
		Master.magnet += 1
		print("Purchased Magnet! Magnet power increased to level ", Master.magnet)
	else:
		print("Not enough money for Magnet! Need $500, have $", Master.getWallet())
	pass # Replace with function body.
