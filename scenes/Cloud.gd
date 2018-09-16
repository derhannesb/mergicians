extends Node2D

var direction = Vector2(0,0)
const clip_boundary = 128

var target_scale = Vector2(0,0)

var stormy = false

var lightning_countdown = rand_range(3,10)

var thickness = 0.0

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
		
	if (stormy):
		thickness = rand_range (1.0/3, 1.0)
	
	self.set_thickness (thickness)

func set_thickness (var percentage):
	thickness = percentage
	
	if percentage < 1.0/4:
		$thin.visible = false
		$medium.visible = false
		$thick.visible = false
	elif percentage < 2.0/4:
		$thin.visible = true
		$medium.visible = false
		$thick.visible = false
	elif percentage < 3.0/4:
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
	if (thickness > 0):
		$Lightning/AnimationPlayer.play("LightningStrike")
		$Thunder.volume_db = -30
		$Thunder.play()
		lightning_countdown = rand_range(3,10)
		self.set_thickness(max(0, thickness-0.25))
	else:
		self.queue_free()
		
func _on_Area2D_body_entered(body):
	if (body.is_in_group("Ship")):
		body.increase_damage(10)
		$Thunder.volume_db = 10
		$Thunder.play()
		
		