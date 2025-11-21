extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var heartarray = [$p1heart1,$p1heart2,$p1heart3]
	$P1HealthLabel.text = str(Global.healthp2)
	if Global.healthp1 == 3:
		for n in [0,1,2]:
			heartarray[n].modulate = Color(1,0,0)
			
	elif Global.healthp1 == 2:
		for n in [0,1]:
			heartarray[n].modulate = Color(1,0,0)
			heartarray[2].modulate = Color(0,0,0)
	elif Global.healthp1 == 1:
		for n in [1,2]:
			heartarray[n].modulate = Color(0,0,0)
			heartarray[0].modulate = Color(1,0,0)
	else:
		for n in [0,1,2]:
			heartarray[n].modulate = Color(0,0,0)
	
	

		
		
