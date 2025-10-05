extends CanvasLayer

@onready var money_amount: Label = $MoneyAmount
@onready var timer: Timer = $Timer
@onready var time_counter: Label = $TimeCounter
var timeBase = 60
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = timeBase + Master.timeAdd
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_amount.text = "$" + str(Master.getWallet())
	time_counter.text = str(time)
	if time <= 0:
		time = timeBase
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	pass


func _on_timer_timeout() -> void:
	time -= 1
	pass # Replace with function body.
