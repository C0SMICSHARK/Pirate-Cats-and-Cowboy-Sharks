extends Node2D
var Shooting = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# IMPORTANT!!! Most sounds use -75db as a default 


func play_soundcheckoptionsmenu():
	$Test.play()
	
func play_revolver():
	Shooting = true
	$RevolverSound.play()
	await $RevolverSound.finished
	Shooting = false

func play_sharkouchies():
	$SharkOuchies.play()
	
func play_catmeowchies():
	$CatMeowchies.play()
	
func play_Jump():
	$Jump.play()
	
func play_SwordHit():
	$SwordHit.play()
	
func play_SwordSwing():
	$SwordSwing.play()
	
func play_CoinGet():
	$CoinGet.play()
	
func play_W():
	$Win.play()
	
func Wet():
	$Moist.play()
	
func Dash():
	$JohnnyTest.play()
