extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(	"Projectile"):
		body.queue_free()
		$StaticBody2D/Area2D.position.y=30000
		$StaticBody2D/CollisionShape2D.position.y=30000
		$StaticBody2D/Sprite2D2.position.y=0.755
		$StaticBody2D/Sprite2D2.position.x=14.345
		$StaticBody2D/Sprite2D.position.y=400000
		#queue_free()
