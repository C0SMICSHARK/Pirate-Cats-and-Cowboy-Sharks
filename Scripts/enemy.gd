extends Node2D

@export var EnemyHealth = 2 * Global.Difficulty
@export var AnimPlayer = Node

func _ready() -> void:
	add_to_group("Enemy")#Useful for collisons
	AnimPlayer.play("EnemySideToSide")
	$CharacterBody2D/AnimatedSprite2D.play("Walk")


func _process(delta) -> void:
	modulate = Color(1,clamp(modulate.g + delta,0,1),clamp(modulate.b + delta,0,1))
	
	# Responsible for making the enemy move side to side as long as it isn't stunned
	if $StunTimer.is_stopped() and $AttackTimer.is_stopped():
		if $GroundImpactTimer.is_stopped():
			AnimPlayer.play()
		if $StunTimer.timeout:
			$GroundImpactTimer.paused = false
		$CharacterBody2D/AnimatedSprite2D.play()
	
	# Destroys enemy after health reaches 0
	if EnemyHealth <= 0:
		queue_free()
	
	# Flips the sprits rotation when it reaches the left/right most point on its track
	if AnimPlayer.get_current_animation_position() <= (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped():
		$CharacterBody2D/AnimatedSprite2D.flip_h = true
	elif AnimPlayer.get_current_animation_position() > (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped() :
		$CharacterBody2D/AnimatedSprite2D.flip_h = false
	
	# Sets enemy and impact collisions to be correct based on if its flipped and/or has attacked
	if $CharacterBody2D/AnimatedSprite2D.flip_h:
		$CharacterBody2D/AttackProximity/CollisionShape2D.position.x = 20
	elif not $CharacterBody2D/AnimatedSprite2D.flip_h:
		$CharacterBody2D/AttackProximity/CollisionShape2D.position.x = -20
	if $GroundImpactTimer.time_left <= 0.1 and $GroundImpactTimer.time_left > 0 and $StunTimer.timeout :
		if $CharacterBody2D/AnimatedSprite2D.flip_h:
			$CharacterBody2D/GroundImpactZone.position.x = 28
			$CharacterBody2D/Hurtbox/CollisionShape2D.position.x = 6
		elif not $CharacterBody2D/AnimatedSprite2D.flip_h:
			$CharacterBody2D/GroundImpactZone.position.x = -28
			$CharacterBody2D/Hurtbox/CollisionShape2D.position.x = -6
		$CharacterBody2D/GroundImpactZone.position.y = 13
	if $GroundImpactTimer.time_left == 0:
		$CharacterBody2D/GroundImpactZone.position.y = -1000
		$CharacterBody2D/Hurtbox/CollisionShape2D.position.x = 0

# Stuns the enemy when hurt and makes it turn red
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(	"Sword"):
		AudioController.play_SwordHit()
	if body.is_in_group(	"PlayerAttack"):
		EnemyHealth -= 1
		modulate = Color(1,0,0)
		if body.is_in_group("Projectile"):
			body.queue_free()
		AnimPlayer.pause()
		$GroundImpactTimer.paused = true
		$StunTimer.start()
		$CharacterBody2D/AnimatedSprite2D.pause()
	
# When the players are close enough, the enemy will attack
func _on_attack_proximity_body_entered(_body: Node2D) -> void:
	if not $CharacterBody2D/AnimatedSprite2D.animation == "Attack":
		$CharacterBody2D/AnimatedSprite2D.play("Attack")
		$AttackTimer.start()
		AnimPlayer.pause()
		$CharacterBody2D/AnimatedSprite2D.scale.x = 0.148
		$CharacterBody2D/AnimatedSprite2D.scale.y = 0.148
		$GroundImpactTimer.start()

# Sets animations to return to noremal after attacking has finished
func _on_animated_sprite_2d_animation_finished() -> void:
	if $CharacterBody2D/AnimatedSprite2D.animation == "Attack":
		$CharacterBody2D/AnimatedSprite2D.scale.x = 0.268
		$CharacterBody2D/AnimatedSprite2D.scale.y = 0.268
		$CharacterBody2D/AnimatedSprite2D.play("Walk")
		
