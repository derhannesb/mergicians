extends RigidBody2D

var pl_wind_generator = preload("res://scenes/WindGenerator.tscn")

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		apply_impulse(Vector2(0,0), Vector2(0,-10))
	if Input.is_action_pressed("right"):
		$PlacementCircle.rotation_degrees += 1
		#apply_impulse(Vector2(0,0), Vector2(10,0))
		
	if Input.is_action_pressed("down"):
		apply_impulse(Vector2(0,0), Vector2(0,10))
	if Input.is_action_pressed("left"):
		$PlacementCircle.rotation_degrees -= 1
	if Input.is_action_pressed("left_secondary"):
		$PlacementCircle/PlacementCircleRotation.rotation_degrees -= 1
	if Input.is_action_pressed("right_secondary"):
		$PlacementCircle/PlacementCircleRotation.rotation_degrees += 1
	if Input.is_action_pressed("action"):
		var wind_generator = pl_wind_generator.instance()
		wind_generator.position = $PlacementCircle/PlacementCircleRotation.global_position
		wind_generator.rotation = $PlacementCircle/PlacementCircleRotation.rotation
		get_parent().add_child(wind_generator)
		
		#apply_impulse(Vector2(0,0), Vector2(-10,0))
	#$Trail/TrailParticles.lifetime = linear_velocity.length() / 20
	#$Trail.rotation = position.angle_to(linear_velocity.normalized()) - PI/2 - rotation
	#$Trail.rotation = - rotation