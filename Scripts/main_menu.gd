extends Node2D

var button_type = null

func _on_start_pressed() -> void:
	button_type = "start"
	$ColorRect.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")

func _on_options_pressed() -> void:
	button_type = "options"
	$ColorRect.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start" :
		get_tree().change_scene_to_file("res://Scenes/TestScene_1.tscn")
	
	elif button_type == "options" :
		get_tree().change_scene_to_file("res://Scenes/TestScene_1.tscn")
	#Idealy this would change to an options screen rather than the level
