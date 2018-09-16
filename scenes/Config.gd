extends Node

var size

var enable_music = false
var enable_sound = false

func _ready():
	size = Vector2 (get_viewport().size.x * 5,
	                get_viewport().size.y * 5)
