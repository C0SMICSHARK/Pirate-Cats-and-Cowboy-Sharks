extends Node2D

@export var EnemyHealth = 2 * Global.Difficulty
@export var AnimPlayer = Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")#Useful for collisons
	AnimPlayer.play("EnemySideToSide")
	$CharacterBody2D/AnimatedSprite2D.play("Walk")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	modulate = Color(1,clamp(modulate.g + delta,0,1),clamp(modulate.b + delta,0,1))
	if $StunTimer.is_stopped() and $AttackTimer.is_stopped():
		AnimPlayer.play()
		$CharacterBody2D/AnimatedSprite2D.play()
	if EnemyHealth <= 0:
		queue_free()
	if AnimPlayer.get_current_animation_position() <= (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped():
		$CharacterBody2D/AnimatedSprite2D.flip_h = true
	elif AnimPlayer.get_current_animation_position() > (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped() :
		$CharacterBody2D/AnimatedSprite2D.flip_h = false
	
	if $CharacterBody2D/AnimatedSprite2D.flip_h:
		$CharacterBody2D/AttackProximity/CollisionShape2D.position.x = 12
	elif not $CharacterBody2D/AnimatedSprite2D.flip_h:
		$CharacterBody2D/AttackProximity/CollisionShape2D.position.x = -12
	
	if $GroundImpactTimer.time_left <= 0.1 and $GroundImpactTimer.time_left > 0:
		if $CharacterBody2D/AnimatedSprite2D.flip_h:
			$CharacterBody2D/GroundImpactZone.position.x = 28
		elif not $CharacterBody2D/AnimatedSprite2D.flip_h:
			$CharacterBody2D/GroundImpactZone.position.x = -28
		$CharacterBody2D/GroundImpactZone.position.y = 13
	if $GroundImpactTimer.time_left == 0:
		$CharacterBody2D/GroundImpactZone.position.y = -1000


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
	$CharacterBody2D/AnimatedSprite2D.play("Attack")
	$AttackTimer.start()
	AnimPlayer.pause()
	$CharacterBody2D/AnimatedSprite2D.scale.x = 0.148
	$CharacterBody2D/AnimatedSprite2D.scale.y = 0.148
	$GroundImpactTimer.start()

func _on_animated_sprite_2d_animation_finished() -> void:
	if $CharacterBody2D/AnimatedSprite2D.animation == "Attack":
		$CharacterBody2D/AnimatedSprite2D.scale.x = 0.268
		$CharacterBody2D/AnimatedSprite2D.scale.y = 0.268
		$CharacterBody2D/AnimatedSprite2D.play("Walk")
