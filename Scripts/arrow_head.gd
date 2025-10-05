extends CharacterBody2D


const SPEED = 600.0
var JUMP_VELOCITY = -400.0
var baseJump = 1
var jump
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var walljumptimer: Timer = $Walljumptimer
@onready var magnet_rad: CollisionShape2D = $Magnet/magnetRad

func _ready() -> void:
	jump = baseJump + Master.jumpAdd
	print("hi")
	magnet_rad.shape.radius *= 1.15 * Master.magnet

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump > 0:
		velocity.y = JUMP_VELOCITY
		jump -= 1
		#print(jump)
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
			#hi here
		else:
			animated_sprite.play("slither")
	else:
			animated_sprite.play("Jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_key_pressed(KEY_R):
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
	pass # Replace with function body.
