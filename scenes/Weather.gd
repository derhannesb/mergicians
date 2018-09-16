extends Node2D

var pl_storm = preload("res://scenes/Storm.tscn")
var pl_cloud = preload("res://scenes/Cloud.tscn")

signal storm_removed

func _ready():
	Config.weather = self
	
	for i in range (20 + randi() % 100):
		generate_cloud()
				
	for i in range (15 + randi() % 20):
		place_storm ()

func generate_cloud(initial_position = null, initial_direction = null):
	var size = Config.size
	var cloud = pl_cloud.instance ()
	var s = rand_range (0.2, 0.6)
	
	cloud.scale = Vector2 (0, 0)
	cloud.target_scale = Vector2(s, s)
	
	cloud.position = Vector2 (rand_range (0.0, size.x),
	                          rand_range (0.0, size.y))
	
	if (initial_position != null):
		cloud.position = initial_position
	
	if (initial_direction != Vector2(0,0)):
		cloud.direction = initial_direction
	self.add_child (cloud)


func place_storm ():
	var size = Config.size
	var storm = pl_storm.instance ()
	storm.position = Vector2 (rand_range (0.0, size.x),
	                          rand_range (0.0, size.y))
	storm.connect("storm_removed", self, "_on_storm_removed")

	self.add_child (storm)
	

func _on_storm_removed():
	place_storm ()
