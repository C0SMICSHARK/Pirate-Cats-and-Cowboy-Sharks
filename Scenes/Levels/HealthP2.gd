extends Node2D

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	$P2HealthLabel.text = str(health)
	$P2HealthBarTexture.position = Vector2(64.25 * (health * 0.01),0.013)
	$P2HealthBarTexture.modulate = Color(1 - (health * 0.01),health * 0.01,0)
	
	if Input.is_action_just_pressed("BREAK"):
		health = health - 1
		
		
