extends Node2D

var CooldownLength = 3
var FireBallPath1 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath2 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath3 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath4 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath5 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath6 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath7 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath8 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath9 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath10 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath11 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath12 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath13 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath14 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath15 = preload("res://Scenes/Objects/FireBall.tscn")
var FireBallPath16 = preload("res://Scenes/Objects/FireBall.tscn")
var Tired = false
var CanAttack = true
@export var HealthNumber = 30
@export var Flag = Node
@export var RedButton = Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$CooldownTimer.start(CooldownLength)
	$FireLaunchTimer.start(2)
	$Kickstart.start()


# Randomize the time between fireball waves, and randoomize spawn positions of fireballs
func _process(delta: float) -> void:
	CooldownLength = randf_range(0.1,0.3)
	$FirePosTest.position.x = randf_range(-2000,2000)
	$FirePosTest2.position.x = randf_range(-2000,2000)
	$FirePosTest3.position.x = randf_range(-2000,2000)
	$FirePosTest4.position.x = randf_range(-2000,2000)
	$FirePosTest5.position.x = randf_range(-2000,2000)
	$FirePosTest6.position.x = randf_range(-2000,2000)
	$FirePosTest7.position.x = randf_range(-2000,2000)
	$FirePosTest8.position.x = randf_range(-2000,2000)
	$FirePosTest9.position.x = randf_range(-2000,2000)
	$FirePosTest10.position.x = randf_range(-2000,2000)
	$FirePosTest11.position.x = randf_range(-2000,2000)
	$FirePosTest12.position.x = randf_range(-2000,2000)
	$FirePosTest13.position.x = randf_range(-2000,2000)
	$FirePosTest14.position.x = randf_range(-2000,2000)
	$FirePosTest15.position.x = randf_range(-2000,2000)
	$FirePosTest16.position.x = randf_range(-2000,2000)

	modulate = Color(1,clamp(modulate.g + delta,0,1),clamp(modulate.b + delta,0,1))
	
	# When Health reaches 0 puases all processes and playes explosion animation
	if HealthNumber == 0:
		$AnimatedSprite2D/DeathExplosion.play("Explode")
		$TiredTimer.paused = true
		$CooldownTimer.paused = true
		$FireLaunchTimer.paused = true
		$CanAttackTimer.paused = true
		$Kickstart.paused = true
		$DizzyStart.paused = true
		$DizzyTotalTimer.paused = true
		$AnimatedSprite2D.pause()
		$AnimatedSprite2D/Hurtbox.position.y = 4500
		HealthNumber -= 1
		
# Responsible for instantiating all the fireballs
func _on_cooldown_timer_timeout() -> void:
	#$AnimatedSprite2D.play("Roar")
	var FireBall1 = FireBallPath1.instantiate()
	FireBall1.pos = $FirePosTest.global_position
	FireBall1.rota = global_rotation
	get_parent().add_child(FireBall1)
	
	var FireBall2 = FireBallPath2.instantiate()
	FireBall2.pos = $FirePosTest2.global_position
	FireBall2.rota = global_rotation
	get_parent().add_child(FireBall2)
	
	var FireBall3 = FireBallPath3.instantiate()
	FireBall3.pos = $FirePosTest3.global_position
	FireBall3.rota = global_rotation
	get_parent().add_child(FireBall3)
	
	var FireBall4 = FireBallPath4.instantiate()
	FireBall4.pos = $FirePosTest4.global_position
	FireBall4.rota = global_rotation
	get_parent().add_child(FireBall4)
	
	var FireBall5 = FireBallPath5.instantiate()
	FireBall5.pos = $FirePosTest5.global_position
	FireBall5.rota = global_rotation
	get_parent().add_child(FireBall5)
	
	var FireBall6 = FireBallPath6.instantiate()
	FireBall6.pos = $FirePosTest6.global_position
	FireBall6.rota = global_rotation
	get_parent().add_child(FireBall6)
	
	var FireBall7 = FireBallPath7.instantiate()
	FireBall7.pos = $FirePosTest7.global_position
	FireBall7.rota = global_rotation
	get_parent().add_child(FireBall7)
	
	var FireBall8 = FireBallPath8.instantiate()
	FireBall8.pos = $FirePosTest8.global_position
	FireBall8.rota = global_rotation
	get_parent().add_child(FireBall8)
	
	var FireBall9 = FireBallPath9.instantiate()
	FireBall9.pos = $FirePosTest9.global_position
	FireBall9.rota = global_rotation
	get_parent().add_child(FireBall9)
	
	var FireBall10 = FireBallPath10.instantiate()
	FireBall10.pos = $FirePosTest10.global_position
	FireBall10.rota = global_rotation
	get_parent().add_child(FireBall10)
	
	var FireBall11 = FireBallPath11.instantiate()
	FireBall11.pos = $FirePosTest11.global_position
	FireBall11.rota = global_rotation
	get_parent().add_child(FireBall11)
	
	var FireBall12 = FireBallPath12.instantiate()
	FireBall12.pos = $FirePosTest12.global_position
	FireBall12.rota = global_rotation
	get_parent().add_child(FireBall12)
	
	var FireBall13 = FireBallPath13.instantiate()
	FireBall13.pos = $FirePosTest13.global_position
	FireBall13.rota = global_rotation
	get_parent().add_child(FireBall13)
	
	var FireBall14 = FireBallPath14.instantiate()
	FireBall14.pos = $FirePosTest14.global_position
	FireBall14.rota = global_rotation
	get_parent().add_child(FireBall14)
	
	var FireBall15 = FireBallPath15.instantiate()
	FireBall15.pos = $FirePosTest15.global_position
	FireBall15.rota = global_rotation
	get_parent().add_child(FireBall15)

	var FireBall16 = FireBallPath16.instantiate()
	FireBall16.pos = $FirePosTest16.global_position
	FireBall16.rota = global_rotation
	get_parent().add_child(FireBall16)

# Responsible for starting a wave of fireballs and repeats as long as its not tired
func _on_fire_launch_timer_timeout() -> void:
	if not Tired and CanAttack:
		$AnimatedSprite2D.position.y = 0
		$AnimatedSprite2D.play("Roar")
		$CooldownTimer.start(CooldownLength)
		$FireLaunchTimer.start(CooldownLength + 1)

# Responsible for starting the chain of functions that makes phases work
func _on_kickstart_timeout() -> void:
	$CanAttackTimer.start()
	CanAttack = true

# Responsible for making it tired and unable to attack
func _on_can_attack_timer_timeout() -> void:
	CanAttack = false
	$TiredTimer.start()
	Tired = true
	$DizzyStart.start()

# Resets the Boss back to being able to attack again
func _on_tired_timer_timeout() -> void:
	$FireLaunchTimer.start(0.5)
	$Kickstart.start(0.5)
	Tired = false
	CanAttack = true

# Starts the dizzy animation and sets the time you can attack it for: "DizzyTotalTimer"
func _on_dizzy_start_timeout() -> void:
	$AnimatedSprite2D.play("Dizzy")
	$AnimatedSprite2D.position.y = 50
	$DizzyTotalTimer.start()
	$AnimatedSprite2D/Hurtbox.position.y = 0

# Makes the dizzy animation change to a tired one for a few seconds
# during this period you can't attack the boss
func _on_dizzy_total_timer_timeout() -> void:
	$AnimatedSprite2D.play("Idle_Low")
	$AnimatedSprite2D/Hurtbox.position.y = 4500

# When hurt the boss will turn red and health number is decremented
func _on_hurtbox_body_entered(body: Node2D) -> void:
	modulate = Color(1,0,0)
	HealthNumber -= 1
	if body.is_in_group("Projectile"):
			body.queue_free()

# When the death animation ends the BIG RED BUTTON is made visible
func _on_death_explosion_animation_finished() -> void:
	Flag.visible = false
	RedButton.visible = true
	$".".position.y = 23000
	$EndSceneTransition.start()

# A few seconds after the boss has dissappeared the scene changes to the end
func _on_end_scene_transition_timeout() -> void:
	get_tree().change_scene_to_file("res://Assets/Misc/End.tscn")
