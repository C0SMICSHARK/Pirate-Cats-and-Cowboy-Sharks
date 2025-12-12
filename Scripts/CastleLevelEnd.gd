extends Area2D
var PlayersNeeded = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if PlayersNeeded > 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_5.tscn")


func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	PlayersNeeded += 1
	#get_tree().change_scene_to_file("res://Assets/Misc/End.tscn")


func _on_body_shape_exited(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	PlayersNeeded -=1
