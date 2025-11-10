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

func _ready() -> void:
	add_to_group("can_interact_with_water")
	add_to_group("Cat")
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP_P1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Movement
	var direction := Input.get_axis("LEFT_P1", "RIGHT_P1")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Dash Mechanic:
	if Input.is_action_just_pressed("DASH") and not dashing:
		dashing = true
		DashTimer.start()
	
	elif Input.is_action_just_pressed("DASH") and dashing :
		dashing = false

	if dashing:
		velocity.x = direction * SPEED * DASH

	if Knocked and not $"../KnockbackTimer".is_stopped():
		t += delta
		$"..".position = $"..".position.lerp(KnockbackVector, delta*10)
	
	if $"../KnockbackTimer".is_stopped():
		move_and_slide()
		Knocked = false

# Dashing Cooldown Mechanic:
func _on_dash_timer_timeout() -> void:
	dashing = false

#Makes the Cat specifically bounce LEFT when hurt
func _on_right_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x-30
	KnockbackVector.y = $"..".position.y-10

#Makes the Cat specifically bounce LEFT when hurt
func _on_left_hurtbox_body_entered(_body: Node2D) -> void:
	Knocked = true
	$"../KnockbackTimer".start()
	KnockbackVector.x = $"..".position.x+30
	KnockbackVector.y = $"..".position.y-10
