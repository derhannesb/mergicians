extends Node2D

var pl_storm = preload("res://scenes/Storm.tscn")
var pl_cloud = preload("res://scenes/Cloud.tscn")

func _ready():
	var size = Config.size
	
	for i in range (30 + randi() % 100):
		var cloud = pl_cloud.instance ()
		cloud.position = Vector2 (rand_range (0.0, size.x),
		                          rand_range (0.0, size.y))
		self.add_child (cloud)
		
	for i in range (15 + randi() % 20):
		var storm = pl_storm.instance ()
		storm.position = Vector2 (rand_range (0.0, size.x),
		                          rand_range (0.0, size.y))
		self.add_child (storm)
		


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
