extends Node
var Difficulty = 1
var healthp1 = clamp(4 - Difficulty,0,3)
var healthp2 = clamp(4 - Difficulty,0,3)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	healthp1 = clamp(healthp1,0,4 - Difficulty)
	healthp2 = clamp(healthp1,0,4 - Difficulty)
