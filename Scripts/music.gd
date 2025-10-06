extends AudioStreamPlayer

var tried_to_start = false

func _ready() -> void:
	print("Music autoload ready. Web platform: ", OS.has_feature("web"))
	print("Initial playing state: ", playing)
	print("Autoplay setting: ", autoplay)
	
	if not OS.has_feature("web"):
		# Desktop: works normally  
		if not playing:
			play()
			print("Desktop: Started music")

func _input(event: InputEvent) -> void:
	# On web, start music on first user interaction
	if OS.has_feature("web") and not tried_to_start:
		if event is InputEventMouseButton or event is InputEventScreenTouch or event is InputEventKey:
			if event.is_pressed():
				tried_to_start = true
				print("User input detected, starting music...")
				play()
				# Check if it worked
				await get_tree().create_timer(0.2).timeout
				print("Music playing after input: ", playing)

