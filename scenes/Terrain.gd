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
	for i in range(0,1):
		generate_island(Vector2(rand_range(0,1920), rand_range(0,1080)))
	
func shuffleList(list):
	var shuffledList = [] 
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi() % indexList.size()
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func generate_island(var position):
	var dx = 128
	var dy = 111
	var elements = Dictionary()
	
	var start_position = position
	
	for a in range(0, 5 + rand_range (1, 16)):
		position = start_position
		for i in range (0, 10):
			var dir = int (rand_range (0, 6))
			if dir == 0:
				position = Vector2 (position.x + dx, position.y)
			elif dir == 1:
				position = Vector2 (position.x + dx/2, position.y + dy)
			elif dir == 2:
				position = Vector2 (position.x - dx/2, position.y + dy)
			elif dir == 3:
				position = Vector2 (position.x - dx, position.y)
			elif dir == 4:
				position = Vector2 (position.x - dx/2, position.y - dy)
			elif dir == 5:
				position = Vector2 (position.x + dx/2, position.y - dy)
				
			var key = "" + str (int(position.x)) + "," + str(int(position.y))
			if not elements.has (key):
				elements[key] = Vector3 (position.x, position.y, 1)
				break
			else:
				elements[key].z += 1
				
	var keys = elements.keys()
	keys = shuffleList (keys)
	
	for key in keys:
		var island_part = pl_island_part.instance()
		if elements[key].z == 1:
			island_part.get_node ("clay").show ()
		elif elements[key].z < 3:
			island_part.get_node ("rocks").show ()
		else:
			island_part.get_node ("grass").show ()
			
		island_part.position = Vector2 (elements[key].x + rand_range (-20, 20),
		                                elements[key].y + rand_range (-20, 20))
		island_part.rotation_degrees = rand_range(0,359)
		self.add_child(island_part)
	