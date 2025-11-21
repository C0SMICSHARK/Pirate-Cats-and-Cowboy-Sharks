extends Node2D
var health = Global.healthp1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	$P1HealthLabel.text = str(Global.healthp1)
	$P1HealthBarTexture.position = Vector2(64.25 * (Global.healthp1 * 0.01),0.013)
	$P1HealthBarTexture.modulate = Color(1 - (Global.healthp1 * 0.01),Global.healthp1 * 0.01,0)
	

		
		
