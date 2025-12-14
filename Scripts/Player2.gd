extends CharacterBody2D
var bullet_path=preload("res://Scenes/Objects/Bullet.tscn")
@onready var bulletCooldown := $"../BulletCooldown"
var Knocked = false
const SPEED = 400.0
var t = 0.0
var KnockbackVector = Vector2(0,0)
var KnockbackForce = Vector2(0,0)
var Flipstuffinnit = 0
var shooting = false
var Impact = false
var Swimming = false



func _ready() -> void:
	add_to_group("can_interact_with_water")
	add_to_group("Shark")
	add_to_group("Player")

	if get_tree().current_scene.name == "Level4":
		$Camera2D.enabled = true
		
	if not get_tree().current_scene.name == "Level4":
		$Camera2D.queue_free()

# Fires a bullet when the function is called
func fire():
	var Bullet=bullet_path.instantiate()
	#Makes the bullet travel the direction the player is facing
	if $AnimatedSprite2D.flip_h:
		$FiringPos.position.x = -20
		Bullet.dir=3.14159
		Flipstuffinnit = -1
	elif not $AnimatedSprite2D.flip_h:
		$FiringPos.position.x = 20
		Bullet.dir=0
		Flipstuffinnit = 1
	Bullet.pos=$FiringPos.global_position
	Bullet.rota=global_rotation
	get_parent().add_child(Bullet)
	bulletCooldown.start()
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x-(0*Flipstuffinnit)
	KnockbackVector.y = $"..".position.y-0
	velocity.x = 0
	KnockbackForce = -velocity
	KnockbackForce.x -= 500
	#if Input.is_action_just_pressed("BREAK"):
		#$AnimatedSprite2D.play("Shoot")
	#else:
		#$AnimatedSprite2D.play("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if get_tree().current_scene.name == "Level4":
		$Camera2D/CameraCollisionRight.global_position = $Camera2D.get_target_position()
	
	
	# Allows shooting to happen when actions is pressed and other actions aren't happening
	if Input.is_action_just_pressed("BREAK") and bulletCooldown.is_stopped() and AudioController.Shooting == false and is_on_floor() == true and not Swimming:
		fire()

	# Handle jump.
	#if Input.is_action_just_pressed("JUMP_P2") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	#Responsible for knockback action
	if Knocked and not $"../KnockbackTimer".is_stopped():
		t += delta
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
	
	# Get the input direction and handle the movement/deceleration.
	var direction_swim := Input.get_vector("LEFT_P2", "RIGHT_P2", "Up_P2", "Down_P2")
	var direction := Input.get_axis("LEFT_P2", "RIGHT_P2")
	
	
	# Plays either Run or Idle if the player is not swimming
	# Also changes movement type if they are swimming
	if direction and not Swimming and bulletCooldown.is_stopped():
		velocity.x = direction * SPEED
		if not Swimming:
			$AnimatedSprite2D.play("Run")
	elif direction_swim and Swimming and bulletCooldown.is_stopped():
		velocity = direction_swim * SPEED
		
	elif bulletCooldown.is_stopped():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if Swimming:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if not Swimming:
			$AnimatedSprite2D.play("Idle")
		
	# Flips sprite direction based on movement direction
	if Input.is_action_just_pressed("LEFT_P2"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_just_pressed("RIGHT_P2"):
		$AnimatedSprite2D.flip_h = false
		
	# Allows shooting to happen when actions is pressed and other actions aren't happening
	if Input.is_action_just_pressed("BREAK") and AudioController.Shooting == false and not Swimming:
		$AnimatedSprite2D.play("Shoot")
		AudioController.play_revolver()
		
	# Happens after ground impact kickstart (Line 144)
	if Impact and not $"../AttackImpactTimer".is_stopped():
		t += delta
		velocity.x = 0
		velocity.y = 0
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
	if $"../AttackImpactTimer".is_stopped():
		Impact = false
	
	# Puts the hitboxes in the correct positions after invincibility window
	if $"../HitImmunity".is_stopped():
		$RightHurtbox.position.y = 0
		$LeftHurtbox.position.y = 0

	# Allows the player to move as long as other actions aren't happening
	if $"../KnockbackTimer".is_stopped() and shooting == false and $"../AttackImpactTimer".is_stopped():
		move_and_slide()
		Knocked = false
		modulate = Color(1,clamp(modulate.g+ delta,0,1),clamp(modulate.b+ delta,0,1))


#Makes the shark specifically bounce LEFT when hurt
func _on_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x-30
	KnockbackVector.y = $"..".position.y-10
	KnockbackForce = -velocity
	KnockbackForce.x -= 500
	$"../HitImmunity".start()
	$RightHurtbox.position.y = -20000
	$LeftHurtbox.position.y = -20000
		#You would probably want to figure out which enemy is damaging you then use a variable instead of 10 but I dont know how to do that - Macie
	Global.healthp2 = Global.healthp2 - 1
	modulate = Color(1,0,0)
	AudioController.play_sharkouchies()

#Makes the shark specifically bounce RIGHT when hurt
func _on_left_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x+30
	KnockbackVector.y = $"..".position.y-10
	KnockbackForce = velocity
	KnockbackForce.x += 500
	$"../HitImmunity".start()
	$RightHurtbox.position.y = -20000
	$LeftHurtbox.position.y = -20000
	Global.healthp2 = Global.healthp2 - 1
	modulate = Color(1,0,0)
	AudioController.play_sharkouchies()

# Kickstarts bouncing the player upwards after a ground impact
func _on_ground_impactbox_body_entered(_body: Node2D) -> void:
	$"../AttackImpactTimer".start()
	Impact = true
	velocity.y=0
	KnockbackVector.x = $"..".position.x+0
	KnockbackVector.y = $"..".position.y-20

# Plays swim animation if the player is inside a swim zone
func _on_swim_box_body_entered(_body: Node2D) -> void:
	Swimming = true
	$AnimatedSprite2D.play("Swim")
	#if Input.is_action_just_pressed("Up_P2"):
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	
func _on_swim_box_body_exited(_body: Node2D) -> void:
	Swimming = false
	motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
