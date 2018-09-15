extends RigidBody2D

var pl_wind_generator = preload("res://scenes/WindGenerator.tscn")
var cooldown = 0

var placement_speed = 3
var placement_speed_rotation = 4


func _ready():
	pass

func _physics_process(delta):
	if (cooldown > 0):
		cooldown -= delta
	else:
		cooldown = 0
		
	$Placement.rotation = - rotation
	
	if Input.is_action_pressed("right"):
		$Placement/PlacementCircle.rotation_degrees += placement_speed
		$Placement/PlacementCircle/PlacementCircleRotation.rotation_degrees -= placement_speed
	if Input.is_action_pressed("left"):
		$Placement/PlacementCircle.rotation_degrees -= placement_speed
		$Placement/PlacementCircle/PlacementCircleRotation.rotation_degrees += placement_speed
	if Input.is_action_pressed("left_secondary"):
		$Placement/PlacementCircle/PlacementCircleRotation.rotation_degrees -= placement_speed_rotation
	if Input.is_action_pressed("right_secondary"):
		$Placement/PlacementCircle/PlacementCircleRotation.rotation_degrees += placement_speed_rotation
	if Input.is_action_pressed("action") && cooldown == 0:
		var wind_generator = pl_wind_generator.instance()
		wind_generator.position = $Placement/PlacementCircle/PlacementCircleRotation.global_position
		wind_generator.rotation = $Placement/PlacementCircle/PlacementCircleRotation.global_rotation - PI
		get_parent().add_child(wind_generator)
		cooldown = 1
	if Input.is_action_pressed ("zoom_in"):
		$Camera2D.zoom *= 0.99
	if Input.is_action_pressed ("zoom_out"):
		$Camera2D.zoom /= 0.99
		
		#apply_impulse(Vector2(0,0), Vector2(-10,0))
	#$Trail/TrailParticles.lifetime = linear_velocity.length() / 20
	#$Trail.rotation = position.angle_to(linear_velocity.normalized()) - PI/2 - rotation
	$Trail/Particles2D.speed_scale = 0.1 + linear_velocity.length() / 50