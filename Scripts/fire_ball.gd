extends Node2D

var pos:Vector2
var rota:float
var dir:float

func _ready() -> void:
	global_position=pos
	global_rotation=rota

# Playes fireball main animation as long as it hasn't impacted
func _process(_delta: float) -> void:
	if $ImpactTimer.is_stopped():
		$RigidBody2D/MainBall.play("Ball")
		$RigidBody2D.freeze = false
		
	if not $ImpactTimer.is_stopped():
		$RigidBody2D.freeze = true

# Plays impact animation after a collision
func _on_rigid_body_2d_body_entered(_body: Node) -> void:
	$RigidBody2D/CollisionShape2D.position.y = -40000
	$RigidBody2D/MainBall.play("Hidden")
	$ImpactTimer.start()
	$RigidBody2D/Impact.play("Impact")

# Destroys after impact animation plays
func _on_impact_animation_finished() -> void:
	queue_free()
