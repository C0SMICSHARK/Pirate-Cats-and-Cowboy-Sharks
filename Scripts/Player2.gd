extends CharacterBody2D
var bullet_path=preload("res://Scenes/Objects/Bullet.tscn")
@onready var bulletCooldown := $"../BulletCooldown"
var Knocked = false
const SPEED = 400.0
var t = 0.0
var KnockbackVector = Vector2(0,0)
var KnockbackForce = Vector2(0,0)
#const JUMP_VELOCITY = -400.0
	

func _ready() -> void:
	add_to_group("can_interact_with_water")
	add_to_group("Shark")
	add_to_group("Player")

func fire():
	var Bullet=bullet_path.instantiate()
	#Makes the bullet travel the direction the player is facing
	if $AnimatedSprite2D.flip_h:
		$FiringPos.position.x = -17
		Bullet.dir=3.14159
	else:
		$FiringPos.position.x = 17
		Bullet.dir=0
	
	Bullet.pos=$FiringPos.global_position
	Bullet.rota=global_rotation
	get_parent().add_child(Bullet)
	bulletCooldown.start()
	#if Input.is_action_just_pressed("BREAK"):
		#$AnimatedSprite2D.play("Shoot")
	#else:
		#$AnimatedSprite2D.play("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("BREAK") and bulletCooldown.is_stopped():
		fire()

	# Handle jump.
	#if Input.is_action_just_pressed("JUMP_P2") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	#Responsible for knockback action
	if Knocked and not $"../KnockbackTimer".is_stopped():
		t += delta
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
		#velocity = KnockbackForce 
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("LEFT_P2", "RIGHT_P2")
	if direction and bulletCooldown.is_stopped():
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Run")
	elif bulletCooldown.is_stopped():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("Idle")
		
		
	if Input.is_action_just_pressed("LEFT_P2"):
		$AnimatedSprite2D.flip_h = true
	
	if Input.is_action_just_pressed("RIGHT_P2"):
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_just_pressed("BREAK"):
		$AnimatedSprite2D.play("Shoot")
		
	
	
	
	

	
	if $"../KnockbackTimer".is_stopped():
		move_and_slide()
		Knocked = false
		

#Makes the shark specifically bounce LEFT when hurt
func _on_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x-30
	KnockbackVector.y = $"..".position.y-10
	KnockbackForce = -velocity
	KnockbackForce.x -= 500

#Makes the shark specifically bounce RIGHT when hurt
func _on_left_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x+30
	KnockbackVector.y = $"..".position.y-10
	KnockbackForce = velocity
	KnockbackForce.x += 500
