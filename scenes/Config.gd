extends Node

var size

func _ready():
	size = Vector2 (get_viewport().size.x * 5,
	                get_viewport().size.y * 5)
