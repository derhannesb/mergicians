extends Node2D

var pl_island_part = preload("res://scenes/IslandPart.tscn")
var pl_water_part = preload("res://scenes/WaterPart.tscn")

func _ready():
	randomize()
	generate_water()
	generate_islands()
	
func generate_water():
	var bigprime = 9973
	var num_x = int (get_viewport().size.x / 111 + 1)
	var num_y = int (get_viewport().size.y / 128 + 2)
	for i in range(0,num_x):
		for a in range(0,num_y):
			var water_part = pl_water_part.instance()
			var x = (i*bigprime) % num_x
			var y = (a*bigprime) % num_y
			water_part.position.x = x * 111
			water_part.position.y = y * 128 - (x%2)*64
			water_part.rotation_degrees = rand_range(0,359)
			self.add_child(water_part)

func generate_islands():
	for i in range(0,10):
		generate_island(Vector2(rand_range(0,1920), rand_range(0,1080)))
	
func generate_island(var position):
	var last_position = position
	for a in range(0,rand_range(2,16)):
		for i in range(0,rand_range(2,16)):
			var island_part = pl_island_part.instance()
			island_part.position = Vector2(last_position.x + rand_range(-20, 20) + (i*20),
			                               last_position.y + rand_range(-20, 20) + (a*20))
			island_part.rotation_degrees = rand_range(0,359)
			self.add_child(island_part)
	