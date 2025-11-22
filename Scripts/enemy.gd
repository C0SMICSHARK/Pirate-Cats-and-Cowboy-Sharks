extends Node2D

@export var EnemyHealth = 2 * Global.Difficulty
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")#Useful for collisons


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if EnemyHealth <= 0:
		queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(	"PlayerAttack"):
		EnemyHealth -= 1
		if body.is_in_group("Projectile"):
			body.queue_free()
		
