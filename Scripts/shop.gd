extends Node2D

@onready var wallet: Label = $CanvasLayer/Wallet
@onready var play: TextureButton = $CanvasLayer/ColorRect/MarginContainer/Play
@onready var moreTime: TextureButton = $CanvasLayer/ColorRect2/MarginContainer/moreTime
@onready var doubleJump: TextureButton = $CanvasLayer/ColorRect3/MarginContainer/DoubleJump
@onready var wallJump: TextureButton = $CanvasLayer/ColorRect4/MarginContainer/WallJump
@onready var magnet: TextureButton = $CanvasLayer/ColorRect5/MarginContainer/Magnet
@onready var quit: TextureButton = $CanvasLayer/ColorRect6/MarginContainer/Quit
@onready var background: Sprite2D = $CanvasLayer/Sprite2D
@onready var canvasLayer: CanvasLayer = $CanvasLayer

# Debug settings - set to false to disable cheat codes
const DEBUG_MODE = true

var x_key_was_pressed = false
var base_window_size = Vector2(1152, 648)  # Base resolution for scaling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make the wallet label much bigger
	wallet.add_theme_font_size_override("font_size", 72)
	
	# Center the wallet label between Play and Quit buttons
	# Play is at x: 61, Quit is at x: 1050
	# Center would be around x: 555 (middle of 1152 base width)
	# Y: 451 (same as Play and Quit buttons)
	wallet.position = Vector2(480, 451)
	wallet.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	# Connect to viewport size changed signal
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	# Initial scaling
	_on_viewport_size_changed()
	
	# Enable audio on mobile web after first user interaction
	if OS.has_feature("web"):
		enable_web_audio()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wallet.text = "$ " +  str(Master.getWallet())
	
	# Debug: Press 'x' to add money for testing (only if DEBUG_MODE is enabled)
	if DEBUG_MODE:
		if Input.is_physical_key_pressed(KEY_X):
			if not x_key_was_pressed:
				Master.wallet += 100
				print("Debug: Added 100 points. Total: ", Master.getWallet())
				x_key_was_pressed = true
		else:
			x_key_was_pressed = false
	
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
		
	if quit.is_hovered():
		quit.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		quit.modulate = Color(1, 1, 1, 1)


func _on_play_pressed() -> void:
	Master.incrementRound()
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

func _on_viewport_size_changed() -> void:
	var current_size = get_viewport().get_visible_rect().size
	var scale_factor = min(current_size.x / base_window_size.x, current_size.y / base_window_size.y)
	
	# Scale the entire CanvasLayer
	canvasLayer.scale = Vector2(scale_factor, scale_factor)
	
	# Center the content
	var scaled_size = base_window_size * scale_factor
	var offset = (current_size - scaled_size) / 2
	canvasLayer.offset = offset
	
	print("Shop scaled to: ", scale_factor, "x, Window size: ", current_size)

func enable_web_audio() -> void:
	# Create a silent audio stream to enable audio context on web
	var silent_audio = AudioStreamWAV.new()
	silent_audio.format = AudioStreamWAV.FORMAT_8_BITS
	silent_audio.mix_rate = 22050
	silent_audio.stereo = false
	silent_audio.data = PackedByteArray([128, 128])  # Silent audio data
	
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = silent_audio
	add_child(audio_player)
	
	# Try to play the silent audio to enable audio context
	audio_player.play()
	
	# Remove the temporary player after a short delay
	await get_tree().create_timer(0.1).timeout
	audio_player.queue_free()
	
	print("Web audio context enabled")

func _on_quit_pressed() -> void:
	# Reset game state
	Master.wallet = 0
	Master.totalAccumulated = 0
	Master.currentRound = 1
	Master.timeAdd = 0
	Master.jumpAdd = 0
	Master.wallJump = false
	Master.magnet = 0
	print("Game reset! Returning to main menu...")
	# Go back to title screen
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	pass # Replace with function body.
