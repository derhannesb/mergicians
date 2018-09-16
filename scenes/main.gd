extends Node2D


func _ready():
	$Music.playing = Config.enable_music
	$AmbientSea.playing = Config.enable_sound
	$AmbientSeaAdditional.playing = Config.enable_sound
	$AmbientSeagulls.playing = Config.enable_sound