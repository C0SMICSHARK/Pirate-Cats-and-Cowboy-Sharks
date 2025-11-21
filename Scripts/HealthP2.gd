extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var heartarray = [$p2heart1,$p2heart2,$p2heart3]
	$P2HealthLabel.text = str(Global.healthp2)
	if Global.healthp2 == 3:
		for n in [0,1,2]:
			heartarray[n].modulate = Color(1,0,0)
			
	elif Global.healthp2 == 2:
		for n in [0,1]:
			heartarray[n].modulate = Color(1,0,0)
			heartarray[2].modulate = Color(0,0,0)
	elif Global.healthp2 == 1:
		for n in [1,2]:
			heartarray[n].modulate = Color(0,0,0)
			heartarray[0].modulate = Color(1,0,0)
	else:
		for n in [0,1,2]:
			heartarray[n].modulate = Color(0,0,0)
		
	
	

	

		
		
