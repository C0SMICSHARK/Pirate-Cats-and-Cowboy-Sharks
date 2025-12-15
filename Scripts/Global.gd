extends Node
var Difficulty = 1
var healthp1 = clamp(4 - Difficulty,0,3)
var healthp2 = clamp(4 - Difficulty,0,3)
var IsMuted = true
var Volume = 50
var Music = 50
var posbeforedeathPlayer1 = Vector2(0,0)
var posbeforedeathPlayer2 = Vector2(0,0)
var RespawnTimeP1 = 5.0
var RespawnTimeP2 = 5.0
var RespawnP1 = false
var RespawnP2 = false
var Score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	if healthp1 <= 0:
		if RespawnTimeP1 > 0:
			RespawnTimeP1 = RespawnTimeP1 - _delta
		else:
			healthp1 = 3
			RespawnP1 = true
			RespawnTimeP1 = 5
			

			
			
	if healthp2 <= 0:
		if RespawnTimeP2 > 0:
			RespawnTimeP2 = RespawnTimeP2 - _delta
		else:
			healthp2 = 3
			RespawnP2 = true
			RespawnTimeP2 = 5
			
	if healthp2 <= 0 and healthp1 <= 0:
		RespawnP2 = true
		RespawnP1 = true
		
		get_tree().reload_current_scene()
		
