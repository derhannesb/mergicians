extends Node2D


func _ready():
	$AnimationPlayer.seek(rand_range(0,5))