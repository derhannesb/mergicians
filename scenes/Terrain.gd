extends Node2D

var pl_island_part = preload("res://scenes/IslandPart.tscn")
var pl_water_part = preload("res://scenes/WaterPart.tscn")

func _ready():
	var size = Vector2 (get_viewport().size.x * 5,
	                    get_viewport().size.y * 5)
	randomize()
	generate_water (size)
	generate_islands (size)
	
func generate_water (var size):
	var bigprime = 9973
	var num_x = int (size.x / 111 + 1)
	var num_y = int (size.y / 128 + 2)
	for i in range(0, num_x):
		for a in range(0, num_y):
			var water_part = pl_water_part.instance ()
			var x = (i*bigprime) % num_x
			var y = (a*bigprime) % num_y
			water_part.position.x = x * 111
			water_part.position.y = y * 128 - (x%2)*64
			water_part.rotation_degrees = rand_range (0, 360)
			self.add_child (water_part)

func shuffleList (var list):
	var shuffledList = [] 
	var indexList = range (list.size())
	for i in range (list.size()):
		var x = randi () % indexList.size()
		shuffledList.append (list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func generate_islands (var size):
	var elements = Dictionary()
	var num_x = int (size.x / (128 * 0.3) + 1)
	var num_y = int (size.y / (111 * 0.3) + 2)

	for i in range(0, 35 + randi() % 40):
		generate_island (elements,
		                 Vector2 (randi () % num_x,
		                          randi () % num_y))
	render_elements (elements)

func generate_island (var elements,
                      var start_position):

	for a in range (0, 20 + rand_range (1, 100)):
		var x = int (start_position.x)
		var y = int (start_position.y)

		for i in range (0, 20):
			var dir = randi () % 6
			var off = y % 1
			
			if dir == 0:
				x += 1
				y += 0
			elif dir == 1:
				x += off
				y += 1
			elif dir == 2:
				x += off - 1
				y += 1
			elif dir == 3:
				x += -1
				y += 0
			elif dir == 4:
				x += off - 1
				y += -1
			elif dir == 5:
				x += off
				y += -1

			var key = str (x) + "," + str (y)
			if elements.has (key):
				elements[key].z += 1
			else:
				elements[key] = Vector3 (x, y, 1)
				break

func render_elements (elements):
	var keys = elements.keys()
	var dx = 128 * 0.3
	var dy = 111 * 0.3
	var claylimit = 2
	var rocklimit = 50
	keys.invert()

	for key in keys:
		var type = elements[key].z

		if type > claylimit:
			continue

		var island_part = pl_island_part.instance ()
		if type < claylimit:
			island_part.get_node ("clay").show ()

		island_part.position = (Vector2 (elements[key].x * dx + (int (elements[key].y) % 2) * dx/2,
		                                 elements[key].y * dy) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)

	for key in keys:
		var type = elements[key].z
		if type <= claylimit or type >= rocklimit:
			continue

		var island_part = pl_island_part.instance ()
		island_part.get_node ("grass").show ()
		island_part.position = (Vector2 (elements[key].x * dx + (int (elements[key].y) % 2) * dx/2,
		                                 elements[key].y * dy) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)

	for key in keys:
		var type = elements[key].z
		if type < rocklimit:
			continue

		var island_part = pl_island_part.instance ()
		island_part.get_node ("rocks").show ()
		island_part.position = (Vector2 (elements[key].x * dx + (int (elements[key].y) % 2) * dx/2,
		                                 elements[key].y * dy) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)