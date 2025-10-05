extends Node2D
@onready var ready_set_go: Timer = $ReadySetGo



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Master.readyGo = false
	ready_set_go.start()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ready_set_go_timeout() -> void:
	Master.readyGo = true
	pass # Replace with function body.
