extends Node2D


func _ready():
	$AnimationPlayer.seek(rand_range(0,5))
	$AnimationPlayer.playback_speed = rand_range (0.7, 1)