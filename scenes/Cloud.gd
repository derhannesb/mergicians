extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var shape = randi () % 3
	
	if shape == 0:
		$shape1.visible = true
	elif shape == 1:
		$shape2.visible = true
	elif shape == 2:
		$shape3.visible = true
		
	self.set_thickness (rand_range (0.0, 1.0))

func set_thickness (var percentage):
	var a
	var g = min (1.0, 1.5 - percentage)
	
	if percentage < 1.0/3:
		$thin.visible = true
		$medium.visible = false
		$thick.visible = false
	elif percentage < 2.0/3:
		$thin.visible = true
		$medium.visible = true
		$thick.visible = false
	else:
		$thin.visible = true
		$medium.visible = true
		$thick.visible = true
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
