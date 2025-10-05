extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var baseJump = 1
var jump
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	jump = baseJump + Master.jumpAdd
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump > 0:
		velocity.y = JUMP_VELOCITY
		jump -= 1
		print(jump)
	if is_on_floor():
		jump = baseJump + Master.jumpAdd
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if(direction > 0):
		animated_sprite.flip_h = false	
	elif(direction < 0):
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("slither")
	else:
			animated_sprite.play("Jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
