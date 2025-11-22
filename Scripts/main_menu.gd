extends Node2D

var button_type = null
var muted = false
var SFX = AudioServer.get_bus_index("SFX")
var Music = AudioServer.get_bus_index("Music")
func _ready() -> void: 
	pass
	AudioServer.set_bus_volume_db(SFX,Global.Volume)
	AudioServer.set_bus_volume_db(Music,Global.Music)
	
func _on_start_pressed() -> void:
	button_type = "start"
	$ColorRect.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")

func _on_options_pressed() -> void:
	button_type = "options"
	$ColorRect.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")
	get_tree().change_scene_to_file("res://Scenes/Levels/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
	
	
func _on_fade_timer_timeout() -> void:
	pass
	#if button_type == "start" :
		#get_tree().change_scene_to_file("res://Scenes/Levels/TestScene_1.tscn")
	
	#elif button_type == "options" :
		#get_tree().change_scene_to_file("res://Scenes/Levels/TestScene_1.tscn")
	#Idealy this would change to an options screen rather than the level
