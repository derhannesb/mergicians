extends Node2D

var pl_island_part = preload("res://scenes/IslandPart.tscn")
var pl_water_part = preload("res://scenes/WaterPart.tscn")

func _ready():
	randomize()
	generate_water()
	generate_islands()
	
func generate_water():
	for i in range(0,get_viewport().size.x / 128 + 1):
		for a in range(0,get_viewport().size.y / 128 + 1):
			var water_part = pl_water_part.instance()
			water_part.position.x = i*128
			water_part.position.y = a*128
			self.add_child(water_part)

func generate_islands():
	for i in range(0,10):
		generate_island(Vector2(rand_range(0,1920), rand_range(0,1080)))
	
func generate_island(var position):
	var last_position = position
	for a in range(0,rand_range(2,16)):
		for i in range(0,rand_range(2,16)):
			var island_part = pl_island_part.instance()
			island_part.position = Vector2(last_position.x + rand_range(-20, 20) + (i*20), last_position.y + rand_range(-20, 20) + (a*20))
			island_part.rotation_degrees = rand_range(0,359)
			self.add_child(island_part)
	