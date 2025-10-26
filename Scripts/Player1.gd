extends CharacterBody2D

#General Variables & Constants:
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#Dash Variables
@export var DASH = 1.8
var dashing = false
@onready var DashTimer = $"../DashTimer"



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

	move_and_slide()

# Dashing Cooldown Mechanic:
func _on_dash_timer_timeout() -> void:
	dashing = false
