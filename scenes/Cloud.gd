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
		a = percentage * 3
		$thin.modulate   = Color (a*g, a*g, a*g, a)
		$medium.modulate = Color (1, 1, 1, 0)
		$thick.modulate  = Color (1, 1, 1, 0)
	elif percentage < 2.0/3:
		a = (percentage - 1.0/3) * 3
		$thin.modulate   = Color (g, g, g, 1)
		$medium.modulate = Color (a*g, a*g, a*g, a)
		$thick.modulate  = Color (1, 1, 1, 0)
	else:
		a = (percentage - 2.0/3) * 3
		$thin.modulate   = Color (g, g, g, 1)
		$medium.modulate = Color (g, g, g, 1)
		$thick.modulate  = Color (a*g, a*g, a*g, a)
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
