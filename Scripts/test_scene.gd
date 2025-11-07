extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("QUIT"):
		get_tree().quit()

#Responsible for fade out effect
func _ready():
	$FadeOut.show()
	$FadeOut/AnimationPlayer.play("Fade_out")
