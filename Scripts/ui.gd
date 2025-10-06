extends CanvasLayer

@onready var money_amount: Label = $MoneyAmount
@onready var timer: Timer = $Timer
@onready var time_counter: Label = $TimeCounter
@onready var store_button: TextureButton = $StoreButton
var timeBase = 15
var time
var player_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = timeBase + Master.timeAdd
	# Find the player node to follow
	player_node = get_tree().get_first_node_in_group("player")
	if not player_node:
		# Try to find the arrow head node
		player_node = get_tree().get_first_node_in_group("arrow_head")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_amount.text = "$" + str(Master.getWallet())
	time_counter.text = str(time)
	if time <= 0:
		time = timeBase
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	
	# Center all UI elements at the bottom of the screen
	var viewport = get_viewport()
	if viewport:
		var screen_size = viewport.get_visible_rect().size
		var bottom_y = screen_size.y - 100  # 100 pixels from bottom (raised up)
		var center_x = screen_size.x / 2
		
		# Centered positioning (accounting for element widths)
		# Shifted left to account for the actual element sizes
		money_amount.position = Vector2(center_x - 300, bottom_y)
		time_counter.position = Vector2(center_x - 125, bottom_y)
		store_button.position = Vector2(center_x + 25 - 50, bottom_y)  # Shift button left by half its width
	
	# Add hover effect to store button
	if store_button.is_hovered():
		store_button.modulate = Color(1.2, 1.2, 1.2, 1)
	else:
		store_button.modulate = Color(1, 1, 1, 1)
	pass


func _on_timer_timeout() -> void:
	time -= 1
	pass # Replace with function body.

func _on_store_button_pressed() -> void:
	print("Store button pressed! Going to shop...")
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
