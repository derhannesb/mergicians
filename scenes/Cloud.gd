extends Node2D

var direction = Vector2(0,0)
const clip_boundary = 128

var target_scale = Vector2(0,0)

func _ready():
	var shape = randi () % 3
	
	direction = Vector2 (rand_range (-0.5, 0.5),
	                     rand_range (-0.5, 0.5))
	
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
		
func _process(delta):
	position += direction
	
	if (position.x  > Config.size.x + clip_boundary):
		position.x -= Config.size.x + 2*clip_boundary - 2
	elif (position.x < -clip_boundary):
		position.x += Config.size.x + 2*clip_boundary - 2
		
	if (position.y  > Config.size.y + clip_boundary):
		position.y -= Config.size.y + 2*clip_boundary - 2
	elif (position.y < -clip_boundary):
		position.y += Config.size.y + 2*clip_boundary - 2

	if (scale < target_scale):
		scale.x += 0.01
		scale.y += 0.01
		