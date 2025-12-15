extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var heartarray = [$p1heart1,$p1heart2,$p1heart3]
	$Label.text = str(Global.RespawnTimeP1)
	if Global.healthp1 > 0:
		$Label.visible = false
	else:
		$Label.visible = true
	if Global.healthp1 > -1:
		$P1HealthLabel.text = str(Global.healthp1)
		
	for n in [0,1,2]:
			heartarray[n].modulate = Color(Global.healthp1-n,1,1,4-Global.Difficulty-n)
 
