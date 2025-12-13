extends Node2D
@export var AnimPlayer = Node
var used = 0

func _ready() -> void:
	pass 

# Plays the animation to make the wall move
func _process(_delta: float) -> void:
	if used == 1:
		AnimPlayer.play("MovingWall")
		used += 1

func _on_area_2d_body_entered(_body: Node2D) -> void:
	used += 1
