extends CanvasLayer

@onready var money_amount: Label = $MoneyAmount
@onready var timer: Timer = $Timer
@onready var time_counter: Label = $TimeCounter
@onready var store_button: TextureButton = $StoreButton
@onready var total_accumulated: Label = $TotalAccumulated
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
	total_accumulated.text = "Total: $" + str(Master.getTotalAccumulated())
	if time <= 0:
		time = timeBase
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	
	# Center all UI elements at the bottom of the screen
	var viewport = get_viewport()
	if viewport:
		var screen_size = viewport.get_visible_rect().size
		var bottom_y = screen_size.y - 150  # 150 pixels from bottom (moved up much higher)
		var center_x = screen_size.x / 2
		
		# Set scale for score and timer (1.5x bigger, using cleaner scale)
		money_amount.scale = Vector2(5.0, 5.0)  # Reduced from 6.0 to 5.0 for less fuzziness
		time_counter.scale = Vector2(5.0, 5.0)  # Reduced from 6.0 to 5.0 for less fuzziness
		total_accumulated.scale = Vector2(3.0, 3.0)  # Smaller scale for total
		
		# Centered positioning (accounting for element widths and scale)
		# Shifted left to account for the actual element sizes
		# Adjusted Y position to account for the larger scale
		money_amount.position = Vector2(center_x - 350, bottom_y - 25)  # Moved further left
		time_counter.position = Vector2(center_x - 175, bottom_y - 25)  # Moved further left
		# Store button is now 2x scale (200x100 pixels), so shift left by 100 to center it
		store_button.position = Vector2(center_x - 125, bottom_y - 25)  # Adjusted for larger button size
		# Total accumulated below the store button
		total_accumulated.position = Vector2(center_x - 100, bottom_y + 75)  # Below store button
	
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
