extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var heartarray = [$p2heart1,$p2heart2,$p2heart3]
	$Label.text = str(Global.RespawnTimeP2)
	if Global.healthp2 > 0:
		$Label.visible = false
	else:
		$Label.visible = true
	if Global.healthp2 > -1:
		$P2HealthLabel.text = str(Global.healthp2)
	for n in [0,1,2]:
			heartarray[n].modulate = Color(Global.healthp2-n,1,1,4-Global.Difficulty-n)
 
		
	
	

	

		
		
