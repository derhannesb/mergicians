extends RigidBody2D

var pl_wind_generator = preload("res://scenes/WindGenerator.tscn")
var cooldown = 0

var placement_speed = 3
var placement_speed_rotation = 4

var max_energy = 100
var energy = max_energy / 2

var storm = null

var score = 0

var max_health = 100
var health = max_health

var wind_cost = 5

func _ready():
	$EnergyBeam.hide()

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
		add_wind_generator()
	if Input.is_action_pressed ("zoom_in"):
		$Camera2D.zoom *= 0.99
	if Input.is_action_pressed ("zoom_out"):
		$Camera2D.zoom /= 0.99
	if Input.is_action_just_pressed ("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		
		#apply_impulse(Vector2(0,0), Vector2(-10,0))
	#$Trail/TrailParticles.lifetime = linear_velocity.length() / 20
	#$Trail.rotation = position.angle_to(linear_velocity.normalized()) - PI/2 - rotation
	$Trail/Particles2D.speed_scale = 0.1 + linear_velocity.length() / 50
	
	# $Ship.rotation = position.angle_to (linear_velocity.normalized()) - PI/2 - rotation
	$Sail.rotation = - rotation
	
	if (storm != null):
		var distance = global_position.distance_to(storm.global_position)
		$EnergyBeam.scale = Vector2(distance / storm.outer_radius, distance / storm.outer_radius) * 2
		$EnergyBeam.global_position = storm.global_position
		$EnergyBeam.rotation = -rotation + storm.global_position.angle_to_point(global_position) - PI


func enter_storm(storm):
	self.storm = storm
	$EnergyBeam.show()
	
func exit_storm():
	self.storm = null
	$EnergyBeam.hide()

func add_wind_generator():
	if (energy > 0):
		var energy_slice = wind_cost
		if (energy-wind_cost < 0):
			energy_slice += energy-wind_cost
			energy = 0
		
		update_energy(-energy_slice)
		
		var wind_generator = pl_wind_generator.instance()
		wind_generator.generated_by = self
		wind_generator.energy = energy_slice * 10
		wind_generator.position = $Placement/PlacementCircle/PlacementCircleRotation.global_position
		wind_generator.rotation = $Placement/PlacementCircle/PlacementCircleRotation.global_rotation - PI
		get_parent().add_child(wind_generator)
		cooldown = 1
		
	
func push_energy(var energy):
	update_energy(energy)

func update_energy(add_energy):
	self.energy += add_energy
	if (self.energy < 0):
		self.energy = 0
	if (self.energy > self.max_energy):
		self.energy = self.max_energy
	$GUI/EnergyMeter.value = self.energy
	
func update_health(add_health):
	health += add_health
	if (health < 0):
		health = 0
		energy = 0
		$GUI/Announcement/AnimationPlayer.play("GameOver")
		$GUI/Announcement.show()
		#self.queue_free()
		self.collision_layer = 0
		self.collision_mask = 0
		self.MODE_STATIC
		
	if (health > max_health):
		health = max_health
	$GUI/Health.value = health
	
		
func increase_score(value):
	score+=value
	$GUI/Score.text = str(score)
	$GUI/ScoreAnimationPlayer.play("Score")

func increase_damage(value):
	update_health(-value)

	