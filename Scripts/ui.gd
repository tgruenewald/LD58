extends CanvasLayer

@onready var money_amount: Label = $MoneyAmount
@onready var timer: Timer = $Timer
@onready var time_counter: Label = $TimeCounter
@onready var store_button: TextureButton = $StoreButton
@onready var total_accumulated: Label = $TotalAccumulated
@onready var round_counter: Label = $RoundCounter
@onready var encouragement_message: Label = $EncouragementMessage
var timeBase = 15
var time
var player_node: Node2D

var snake_messages = [
	"Sssslither to victory! 🐍",
	"You're hiss-terically good at this!",
	"Don't be a garden snake, be a CHAMPION!",
	"Fangs for playing! Keep going!",
	"You're ssssensational!",
	"Scale to new heights!",
	"That's un-boa-lievable!",
	"You're not sssslacking!",
	"Viper-formance at its finest!",
	"Adder-boy! Looking good!",
	"Python your way to the top!",
	"You're rattling the competition!",
	"Cobra-lieve in yourself!",
	"Anaconda see you're doing great!",
	"You're the snake of legends!",
	"Keep shed-ding those records!",
	"You've got some serious constrictor skills!",
	"Hiss-tory in the making!",
	"Snake? More like GREAT!",
	"You're venomously good at this!",
	"Ssssimply amazing!"
]
var current_message_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = timeBase + Master.timeAdd
	# Find the player node to follow
	player_node = get_tree().get_first_node_in_group("player")
	if not player_node:
		# Try to find the arrow head node
		player_node = get_tree().get_first_node_in_group("arrow_head")
	
	# Pick a random encouragement message
	current_message_index = randi() % snake_messages.size()
	encouragement_message.text = snake_messages[current_message_index]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_amount.text = "$" + str(Master.getWallet())
	time_counter.text = str(time)
	total_accumulated.text = "Total: $" + str(Master.getTotalAccumulated())
	round_counter.text = "Round: " + str(Master.getCurrentRound())
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
		round_counter.scale = Vector2(3.0, 3.0)  # Same scale as total
		encouragement_message.scale = Vector2(1.5, 1.5)  # Smaller scale for encouragement
		
		# Centered positioning (accounting for element widths and scale)
		# Shifted left to account for the actual element sizes
		# Adjusted Y position to account for the larger scale
		money_amount.position = Vector2(center_x - 450, bottom_y - 25)  # Moved even further left to prevent overlap
		time_counter.position = Vector2(center_x - 250, bottom_y - 25)  # Adjusted for better spacing
		# Store button is now 2x scale (200x100 pixels), so shift left by 100 to center it
		store_button.position = Vector2(center_x - 125, bottom_y - 25)  # Adjusted for larger button size
		# Encouragement message below the store button
		encouragement_message.position = Vector2(center_x - 210, bottom_y + 55)  # Just below store button
		# Total accumulated aligned under the money amount
		total_accumulated.position = Vector2(center_x - 450, bottom_y + 80)  # Aligned with money_amount
		# Round counter aligned under the time counter
		round_counter.position = Vector2(center_x - 250, bottom_y + 80)  # Aligned with time_counter
	
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
