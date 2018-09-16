extends Node2D

var direction = Vector2(0,0)
const clip_boundary = 128

var target_scale = Vector2(0,0)

var stormy = false

var lightning_countdown = rand_range(3,10)

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
		
	var thickness = 0.0
	if (stormy):
		thickness = rand_range (1.0/3, 1.0)
	
	self.set_thickness (thickness)

func set_thickness (var percentage):
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
	if (stormy):
		lightning_countdown -= delta
		if (lightning_countdown <= 0):
			lightning_strike()
	
	if (position.x  > Config.size.x + clip_boundary):
		position.x -= Config.size.x + 2*clip_boundary - 2
	elif (position.x < -clip_boundary):
		position.x += Config.size.x + 2*clip_boundary - 2
		
	if (position.y  > Config.size.y + clip_boundary):
		position.y -= Config.size.y + 2*clip_boundary - 2
	elif (position.y < -clip_boundary):
		position.y += Config.size.y + 2*clip_boundary - 2

	if (scale < target_scale):
		scale.x += 0.005
		scale.y += 0.005

func lightning_strike():
	$Lightning/AnimationPlayer.play("LightningStrike")
	lightning_countdown = rand_range(3,10)
	

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Ship")):
		body.increase_damage(10)
		