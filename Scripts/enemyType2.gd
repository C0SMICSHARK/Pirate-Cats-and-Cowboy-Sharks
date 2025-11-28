extends Node2D

@export var EnemyHealth = 2 * Global.Difficulty
@export var AnimPlayer = Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")#Useful for collisons
	AnimPlayer.play("EnemySideToSide")
	$CharacterBody2D/AnimatedSprite2D.play("WalkLeft")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	modulate = Color(1,clamp(modulate.g + delta,0,1),clamp(modulate.b + delta,0,1))
	if $StunTimer.is_stopped():
		AnimPlayer.play()
		$CharacterBody2D/AnimatedSprite2D.play()
	if EnemyHealth <= 0:
		queue_free()
	if AnimPlayer.get_current_animation_position() <= (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped():
		$CharacterBody2D/AnimatedSprite2D.play("WalkRight")
	elif AnimPlayer.get_current_animation_position() > (AnimPlayer.get_current_animation_length() / 2) and $StunTimer.is_stopped() :
		$CharacterBody2D/AnimatedSprite2D.play("WalkLeft")


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
	
	
