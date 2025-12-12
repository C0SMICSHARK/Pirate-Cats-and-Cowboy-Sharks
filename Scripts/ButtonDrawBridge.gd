extends Node2D
@export var DrawBridgeUp = Node
@export var DrawBridgeDown = Node
@export var DrawBridgeUpCol = Node
@export var DrawBridgeDownCol = Node
var used = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if used == 1:
		DrawBridgeDown.visible = true
		DrawBridgeUp.visible = false
		DrawBridgeUpCol.position.y = 2000
		DrawBridgeDownCol.position.y = 67.0
		used += 1


func _on_area_2d_body_entered(_body: Node2D) -> void:
	used += 1
	
	
