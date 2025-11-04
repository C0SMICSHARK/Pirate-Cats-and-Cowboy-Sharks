extends CharacterBody2D

var pos:Vector2
var rota:float
var dir:float
var speed=2000


func _ready():
	add_to_group("Projectile")#useful for breakable walls
	global_position=pos
	global_rotation=rota
func _physics_process(_delta):
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()
	if velocity.x == 0:
		queue_free()
		
