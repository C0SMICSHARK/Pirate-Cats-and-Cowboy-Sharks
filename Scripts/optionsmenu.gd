extends Node2D

var button_type = null
var muted = false
var SFX = AudioServer.get_bus_index("SFX")
var Music = AudioServer.get_bus_index("Music")
func _ready() -> void: 
	pass	
	$Mute2.button_pressed = Global.IsMuted
	$VolumeSlider.set_value_no_signal(Global.Volume)
	$MusicSlider.set_value_no_signal(Global.Music)

func _process(delta: float) -> void:
	pass
	$VolumeLabel.text = ("Audio: " + str(int(Global.Volume)))
	$MusicLabel.text = ("Music: " + str(int(Global.Music)))
func _on_back_pressed() -> void:
	pass # Replace with function body.
	button_type = "back"
	$ColorRect.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

func _on_fade_timer_timeout() -> void:
	pass
	#if button_type == "start" :
		#get_tree().change_scene_to_file("res://Scenes/Levels/TestScene_1.tscn")
	
	#elif button_type == "options" :
		#get_tree().change_scene_to_file("res://Scenes/Levels/TestScene_1.tscn")
	#Idealy this would change to an options screen rather than the level

# Used for Audio Change

	
	pass # Replace with function body.

func _on_back_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.

	


func _on_difficulty_item_selected(index: int) -> void:
	match index:
		0:
			Global.Difficulty = 1
		1:  
			Global.Difficulty = 2        
		2:
			Global.Difficulty = 3 


func _on_resolution_item_selected(index: int) -> void:
	match index: # Replace with function body.#
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
		
		3:
			DisplayServer.window_set_size(Vector2i(720,480))


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		
		DisplayServer.WINDOW_MODE_FULLSCREEN
		
	else:
			DisplayServer.WINDOW_MODE_WINDOWED
	

func _on_mute_2_toggled(toggled_on: bool) -> void:
	pass # Replace with fu
	AudioServer.set_bus_mute(0,toggled_on)
	Global.IsMuted = toggled_on
	AudioController.play_soundcheckoptionsmenu()
	
	


func _on_volume_slider_audio_value_changed(value: float) -> void:
	var Audio = int(value) 
	AudioServer.set_bus_volume_db(SFX,value)
	Global.Volume=value
	AudioController.play_soundcheckoptionsmenu()


func _on_music_slider_value_changed(value: float) -> void:
	var MusicValue = int(value) 
	AudioServer.set_bus_volume_db(Music,MusicValue)
	Global.Music=MusicValue
	MusicController.play_SoundCheckMusic()
