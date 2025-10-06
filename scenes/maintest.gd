extends Node2D
@onready var ready_set_go: Timer = $ReadySetGo



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Master.readyGo = false
	ready_set_go.start()
	
	# Enable audio on mobile web
	if OS.has_feature("web"):
		enable_web_audio()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ready_set_go_timeout() -> void:
	Master.readyGo = true
	pass # Replace with function body.

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
