extends Node2D

var pl_island_part = preload("res://scenes/IslandPart.tscn")
var pl_water_part = preload("res://scenes/WaterPart.tscn")
var pl_windmill = preload("res://scenes/Windmill.tscn")

var size
var elements

var dx = 128 * 0.3
var dy = 111 * 0.3
var claylimit = 2
var rocklimit = 50

func _ready():
	size = Config.size
	elements = Dictionary ()
	randomize()
	generate_water ()
	generate_boundary ()
	generate_islands ()
	generate_windmills ()

func generate_water ():
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

func generate_boundary ():
	for x in range (0, int (size.x / dx) + 1):
		var island_part = pl_island_part.instance ()
		island_part.get_node ("clay").show ()
		island_part.position = (Vector2 (x * dx, 0) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)

		island_part = pl_island_part.instance ()
		island_part.get_node ("clay").show ()
		island_part.position = (Vector2 (x * dx, size.y) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)

	for y in range (0, int (size.y / dy) + 1):
		var island_part = pl_island_part.instance ()
		island_part.get_node ("clay").show ()
		island_part.position = (Vector2 (0, y * dy) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)

		island_part = pl_island_part.instance ()
		island_part.get_node ("clay").show ()
		island_part.position = (Vector2 (size.x, y * dy) +
		                        Vector2 (rand_range (-7,7), rand_range (-7,7)))
		island_part.rotation_degrees = rand_range (0,359)
		self.add_child (island_part)
	
	
func shuffleList (var list):
	var shuffledList = [] 
	var indexList = range (list.size())
	for i in range (list.size()):
		var x = randi () % indexList.size()
		shuffledList.append (list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func get_free_space ():
	var num_x = int (size.x / (128 * 0.3) + 1)
	var num_y = int (size.y / (111 * 0.3) + 2)
	
	var x = num_x / 2
	var y = num_y / 2
	
	while true:
		var key = str (x) + "," + str (y)
		if not elements.has (key):
			break
		x += (randi () % 3) - 1
		y += (randi () % 3) - 1

	return Vector2 (x, y)
	
func generate_islands ():
	var elements = Dictionary()
	var num_x = int (size.x / (128 * 0.3) + 1)
	var num_y = int (size.y / (111 * 0.3) + 2)

	for i in range(0, 35 + randi() % 40):
		generate_island (Vector2 (randi () % num_x,
		                          randi () % num_y))
	render_elements ()

func generate_island (var start_position):

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

func render_elements ():
	var keys = elements.keys()
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
		
func generate_windmills ():
	var keys = elements.keys ()
	keys = shuffleList (keys)
	
	var num_mills = 20 + randi () % 20
	
	for key in keys:
		var e = elements[key]
		if e.z > claylimit and e.z < rocklimit:
			var mill = pl_windmill.instance ()
			mill.position = Vector2 (e.x * dx + (int (e.y) % 2) * dx/2, e.y * dy)
			self.add_child (mill)
			num_mills -= 1
			if num_mills <= 0:
				break
		
	