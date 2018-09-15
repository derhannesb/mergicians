extends RigidBody2D

var pl_wind_generator = preload("res://scenes/WindGenerator.tscn")
var cooldown = 0

func _ready():
	pass

func _physics_process(delta):
	if (cooldown > 0):
		cooldown -= delta
	else:
		cooldown = 0
	
	
	if Input.is_action_pressed("right"):
		$PlacementCircle.rotation_degrees += 3
	if Input.is_action_pressed("left"):
		$PlacementCircle.rotation_degrees -= 3
	if Input.is_action_pressed("left_secondary"):
		$PlacementCircle/PlacementCircleRotation.rotation_degrees -= 4
	if Input.is_action_pressed("right_secondary"):
		$PlacementCircle/PlacementCircleRotation.rotation_degrees += 4
	if Input.is_action_pressed("action") && cooldown == 0:
		var wind_generator = pl_wind_generator.instance()
		wind_generator.position = $PlacementCircle/PlacementCircleRotation.global_position
		wind_generator.rotation = $PlacementCircle/PlacementCircleRotation.global_rotation - PI
		get_parent().add_child(wind_generator)
		cooldown = 1
		
		#apply_impulse(Vector2(0,0), Vector2(-10,0))
	#$Trail/TrailParticles.lifetime = linear_velocity.length() / 20
	#$Trail.rotation = position.angle_to(linear_velocity.normalized()) - PI/2 - rotation
	#$Trail.rotation = - rotation