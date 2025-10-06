extends CharacterBody2D


const SPEED = 600.0
var JUMP_VELOCITY = -400.0
var baseJump = 1
var jump
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var walljumptimer: Timer = $Walljumptimer
@onready var magnet_rad: CollisionShape2D = $Magnet/magnetRad

# Mobile touch controls
var touch_start_position: Vector2
var touch_threshold = 50.0  # Minimum distance for touch movement
var is_touching = false
var touch_direction = 0.0  # Store touch direction for physics process
var should_jump = false  # Store jump input for physics process

func _ready() -> void:
	jump = baseJump + Master.jumpAdd
	print("hi")
	magnet_rad.shape.radius *= 1.15 * Master.magnet

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump - support both old and new input actions, plus mobile
	if ((Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) or should_jump) and jump > 0:
		velocity.y = JUMP_VELOCITY
		jump -= 1
		should_jump = false  # Reset jump input after using it
		print("Jump! Remaining jumps: ", jump)
	if is_on_floor():
		jump = baseJump + Master.jumpAdd
	
	# Get the input direction - support both old and new input actions
	var direction := Input.get_axis("ui_left", "ui_right")
	# Also check for WASD controls
	if Input.is_action_pressed("move_left"):
		direction = -1.0
	elif Input.is_action_pressed("move_right"):
		direction = 1.0
	
	# Include mobile touch direction
	if touch_direction != 0.0:
		direction = touch_direction
	if(direction > 0):
		animated_sprite.flip_h = false	
	elif(direction < 0):
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
			#hi here
		else:
			animated_sprite.play("slither")
	else:
			animated_sprite.play("Jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_key_pressed(KEY_Z):
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	move_and_slide()
	


func _on_walljumptimer_timeout() -> void:
	jump -= 1
	pass # Replace with function body.


func _on_walldetectleft_body_entered(body: Node2D) -> void:
	print("can walljump")
	if Master.wallJump:
		jump += 1
		walljumptimer.start()
	pass # Replace with function body.


func _on_wall_detect_right_body_entered(body: Node2D) -> void:
	print("can walljump")
	if Master.wallJump:
		jump += 1
		walljumptimer.start()

# Mobile touch input handling
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_start_position = event.position
			is_touching = true
			print("Touch started at: ", event.position)  # Debug output
			
			# Use touch position to determine action
			var screen_width = get_viewport().get_visible_rect().size.x
			var screen_height = get_viewport().get_visible_rect().size.y
			
			# Top half of screen = jump
			if event.position.y < screen_height / 2:
				should_jump = true
				print("Touch on top half, jumping!")
			# Bottom half = movement
			elif event.position.x < screen_width / 2:
				touch_direction = -1.0  # Left side of screen = move left
				print("Touch on left side, moving left")
			else:
				touch_direction = 1.0   # Right side of screen = move right
				print("Touch on right side, moving right")
		else:
			is_touching = false
			touch_direction = 0.0  # Reset direction when touch ends
			print("Touch ended, stopping movement")
	
	elif event is InputEventScreenDrag:
		if is_touching:
			var touch_distance_x = event.position.x - touch_start_position.x
			var touch_distance_y = event.position.y - touch_start_position.y
			print("Touch drag - X: ", touch_distance_x, " Y: ", touch_distance_y)  # Debug output
			
			# Check for vertical swipe (jump)
			if abs(touch_distance_y) > touch_threshold and abs(touch_distance_y) > abs(touch_distance_x):
				if touch_distance_y < 0:  # Swipe up
					should_jump = true
					print("Swipe up detected, jumping!")
			# Check for horizontal swipe (movement)
			elif abs(touch_distance_x) > touch_threshold:
				touch_direction = 1.0 if touch_distance_x > 0 else -1.0
				print("Touch direction set to: ", touch_direction)  # Debug output
			else:
				touch_direction = 0.0  # Reset if not enough movement
