extends CharacterBody2D

#General Variables & Constants:
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#Dash Variables
@export var DASH = 1.8
var dashing = false
@onready var DashTimer = $"../DashTimer"
var t = 0.0
var KnockbackVector = Vector2(0,0)
var Knocked = false
var HasJumped = false
var JumpApex = false
var Walking = false
var AttackHit = false

func _ready() -> void:
	add_to_group("can_interact_with_water")
	add_to_group("Cat")
	add_to_group("Player")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("JUMP_P1") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#HasJumped = true
		#$AnimatedSprite2D.play("Jump")
		
	if $"../AttackTimer".is_stopped():
		$AttackHitbox.position.y = 1000
	
	if is_on_floor():
		HasJumped = false
		if JumpApex:
			$AnimatedSprite2D.play("JumpLand")

	#Movement
	var direction := Input.get_axis("LEFT_P1", "RIGHT_P1")
	
	if direction:
		velocity.x = direction * SPEED
	if direction and not HasJumped and not JumpApex and $"../AttackTimer".is_stopped():
		#velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Walk")
		Walking = true
		$AnimatedSprite2D.position.y = 3
		
	elif not HasJumped and not JumpApex and $"../AttackTimer".is_stopped():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("Idle")#
		$AnimatedSprite2D.position.y = -1
	
	if Input.is_action_just_pressed("LEFT_P1"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.rotation_degrees = -3
		
	if Input.is_action_just_pressed("RIGHT_P1"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.rotation_degrees = 3
		
	if Input.is_action_just_pressed("JUMP_P1") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		HasJumped = true
		$AnimatedSprite2D.play("JumpStart")
		$AnimatedSprite2D.position.y = 0
		AudioController.play_Jump()
	#Dash Mechanic:
	if Input.is_action_just_pressed("DASH") and not dashing:
		dashing = true
		AudioController.Dash()
		DashTimer.start()
	
	elif Input.is_action_just_pressed("DASH") and dashing :
		dashing = false

	if dashing:
		velocity.x = direction * SPEED * DASH

	if Knocked and not $"../KnockbackTimer".is_stopped():
		t += delta
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
	
	if AttackHit and not $"../AttackImpactTimer".is_stopped():
		t += delta
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
	
	if $"../AttackImpactTimer".is_stopped():
		AttackHit = false
	
	if $"../KnockbackTimer".is_stopped() and $"../AttackImpactTimer".is_stopped():
		move_and_slide()
		Knocked = false
		modulate = Color(1,clamp(modulate.g+ delta,0,1),clamp(modulate.b+ delta,0,1))
		
	
	if Input.is_action_just_pressed("CatAttack") and $"../AttackTimer".is_stopped() == true:
		AudioController.play_SwordSwing()
		$"../AttackTimer".start()
		$AnimatedSprite2D.position.y = 1.5
		$AnimatedSprite2D.play("Attack")
		if not $AnimatedSprite2D.flip_h:
			$AttackHitbox.position.x = 13.5
			$AttackHitbox.position.y = 0
		elif $AnimatedSprite2D.flip_h:
			$AttackHitbox.position.x = -13.5
			$AttackHitbox.position.y = 0
			AudioController.play_SwordSwing()
# Dashing Cooldown Mechanic:
func _on_dash_timer_timeout() -> void:
	dashing = false

#Makes the Cat specifically bounce LEFT when hurt
func _on_right_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x-30
	KnockbackVector.y = $"..".position.y-10
	HasJumped = true
	#You would probably want to figure out which enemy is damaging you then use a variable instead of 10 but I dont know how to do that - Macie
	Global.healthp1 = Global.healthp1 - 1
	modulate = Color(1,0,0)
	AudioController.play_catmeowchies()
#Makes the Cat specifically bounce LEFT when hurt
func _on_left_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x+30
	KnockbackVector.y = $"..".position.y-10
	HasJumped = true
	#You would probably want to figure out which enemy is damaging you then use a variable instead of 10 but I dont know how to do that - Macie
	Global.healthp1 = Global.healthp1 - 1
	modulate = Color(1,0,0)
	AudioController.play_catmeowchies()
func _on_animated_sprite_2d_animation_finished() -> void:
	if  $AnimatedSprite2D.animation == "JumpStart":
		$AnimatedSprite2D.play("JumpApex")
	if  $AnimatedSprite2D.animation == "JumpApex":
		JumpApex = true
	if  $AnimatedSprite2D.animation == "JumpLand":
		JumpApex = false
		velocity.x = 0
	if  $AnimatedSprite2D.animation == "Attack" and not is_on_floor():
		JumpApex = true
		$AnimatedSprite2D.play("JumpApex")
		$AnimatedSprite2D.position.y = 0
	
func _on_hit_impact_body_entered(_body: Node2D) -> void:
	$"../AttackImpactTimer".start()
	AttackHit = true
	velocity.y=0
	$AttackHitbox.position.y = 1000
	if not $AnimatedSprite2D.flip_h:
		KnockbackVector.x = $"..".position.x-20
		KnockbackVector.y = $"..".position.y-0
	elif  $AnimatedSprite2D.flip_h:
		KnockbackVector.x = $"..".position.x+20
		KnockbackVector.y = $"..".position.y-0
