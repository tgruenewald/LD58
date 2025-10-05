extends Node
var instance
func _ready() -> void:
	var scene = preload("res://scenes/collectable.tscn")
	instance = scene.instantiate()
	
	var baseX = -6500
	var baseY = -1000
	for j in 15:
		for i in 500:
			instance = scene.instantiate()
			instance.global_position = Vector2(baseX + (i*112), baseY +(j*112))
			add_child(instance)
	pass # Replace with function body.
func _process(delta: float) -> void:
	
	pass
