extends Node2D

@export var EnemyHealth = 2 * Global.Difficulty
@export var AnimPlayer = Node
var Spear_Path=preload("res://Scenes/Objects/Spear.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")#Useful for collisons
	AnimPlayer.play("EnemySideToSide")
	$CharacterBody2D/AnimatedSprite2D.play("WalkLeft")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	modulate = Color(1,clamp(modulate.g + delta,0,1),clamp(modulate.b + delta,0,1))
	if $StunTimer.is_stopped() and $AttackTimer.is_stopped():
		AnimPlayer.play()
		$CharacterBody2D/AnimatedSprite2D.play()
	if EnemyHealth <= 0:
		queue_free()
	if AnimPlayer.get_current_animation_position() <= (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped() and $AttackTimer.is_stopped():
		$CharacterBody2D/AnimatedSprite2D.play("WalkRight")
		$CharacterBody2D/CollisionShape2D.position.x = 4
		$CharacterBody2D/Hurtbox/CollisionShape2D.position.x = 4
		$CharacterBody2D/CollisionShape2D.rotation_degrees += 180
		$CharacterBody2D/Hurtbox/CollisionShape2D.rotation_degrees += 180
		
	elif AnimPlayer.get_current_animation_position() > (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped() and $AttackTimer.is_stopped() :
		$CharacterBody2D/AnimatedSprite2D.play("WalkLeft")
		$CharacterBody2D/CollisionShape2D.position.x = -4
		$CharacterBody2D/Hurtbox/CollisionShape2D.position.x = -4
		$CharacterBody2D/CollisionShape2D.rotation_degrees -= 180
		$CharacterBody2D/Hurtbox/CollisionShape2D.rotation_degrees -= 180
		
	if $CharacterBody2D/AnimatedSprite2D.animation == "WalkLeft" or $CharacterBody2D/AnimatedSprite2D.animation == "AttackLeft":
			$CharacterBody2D/AttackProximity/CollisionShape2D.position.x=-55
	if $CharacterBody2D/AnimatedSprite2D.animation == "WalkRight" or $CharacterBody2D/AnimatedSprite2D.animation == "AttackRight":
			$CharacterBody2D/AttackProximity/CollisionShape2D.position.x=55

func throw():
	var Spear = Spear_Path.instantiate()
	Spear.pos=$CharacterBody2D/AnimatedSprite2D.global_position
	if $CharacterBody2D/AnimatedSprite2D.animation == "AttackLeft":
		Spear.dir=-300.0
		Spear.rota=0
	elif $CharacterBody2D/AnimatedSprite2D.animation == "AttackRight":
		Spear.dir=300.0
		Spear.rota=3.14
	get_parent().add_child(Spear)
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(	"Sword"):
		AudioController.play_SwordHit()
	
	if body.is_in_group(	"PlayerAttack"):
		EnemyHealth -= 1
		modulate = Color(1,0,0)
		if body.is_in_group("Projectile"):
			body.queue_free()
		AnimPlayer.pause()
		$StunTimer.start()
		$CharacterBody2D/AnimatedSprite2D.pause()
	
	
func _on_attack_proximity_body_entered(_body: Node2D) -> void:
	if $AttackTimer.is_stopped():
		$AttackTimer.start()
		AnimPlayer.pause()
		if $CharacterBody2D/AnimatedSprite2D.animation == "WalkLeft":
			$CharacterBody2D/AnimatedSprite2D.play("AttackLeft")
		elif $CharacterBody2D/AnimatedSprite2D.animation == "WalkRight":
			$CharacterBody2D/AnimatedSprite2D.play("AttackRight")
		throw()
