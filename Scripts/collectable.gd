extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if Master.readyGo == false:
		queue_free()
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	Master.addPick()
	animation_player.play("PickUp")
	pass # Replace with function body.
