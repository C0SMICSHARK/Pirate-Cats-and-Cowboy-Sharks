extends CharacterBody2D
var bullet_path=preload("res://Scenes/Bullet.tscn")

const SPEED = 400.0
#const JUMP_VELOCITY = -400.0
	

func _ready() -> void:
	add_to_group("can_interact_with_water")

func fire():
	var Bullet=bullet_path.instantiate()
	Bullet.dir=rotation
	Bullet.pos=$FiringPos.global_position
	Bullet.rota=global_rotation
	get_parent().add_child(Bullet)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("BREAK"):
		fire()

	# Handle jump.
	#if Input.is_action_just_pressed("JUMP_P2") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("LEFT_P2", "RIGHT_P2")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
