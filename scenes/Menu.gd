extends Node2D

func _ready():
	pass

func _on_Button_pressed():
	Config.enable_sound = $CanvasLayer/SoundToggle.pressed
	Config.enable_music = $CanvasLayer/MusicToggle.pressed

	get_tree().change_scene("scenes/Main.tscn")
