extends Node2D

var pos:Vector2
var rota:float
var dir:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position=pos
	global_rotation=rota


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $ImpactTimer.is_stopped():
		$RigidBody2D/MainBall.play("Ball")
		$RigidBody2D.freeze = false
		
	if not $ImpactTimer.is_stopped():
		$RigidBody2D.freeze = true

func _on_rigid_body_2d_body_entered(_body: Node) -> void:
	$RigidBody2D/CollisionShape2D.position.y = -40000
	$RigidBody2D/MainBall.play("Hidden")
	$ImpactTimer.start()
	$RigidBody2D/Impact.play("Impact")

func _on_impact_animation_finished() -> void:
	#$RigidBody2D.position.y = 0
	#$RigidBody2D.constant_force.y = 0
	queue_free()
