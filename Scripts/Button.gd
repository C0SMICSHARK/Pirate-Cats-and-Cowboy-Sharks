extends Node2D
@export var AnimPlayer = Node
var used = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if used == 1:
		AnimPlayer.play("MovingWall")
		used += 1


func _on_area_2d_body_entered(_body: Node2D) -> void:
	used += 1
	#AnimPlayer.play("MovingWall")
	
