extends Node2D

var pos:Vector2
var rota:float
var dir:float
var speed=300


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position=pos
	global_rotation=rota
	$RigidBody2D.apply_central_impulse(Vector2(dir,-200))
	$DespawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $DespawnTimer.is_stopped():
		queue_free()
