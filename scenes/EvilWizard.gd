extends KinematicBody2D

var current_direction
var on_island = true
var speed = 50
var time_to_change = rand_range(2,6)

var next_cloud = rand_range(5,10)

func _ready():
	randomize()
	change_direction()
	
func change_direction():
	current_direction = Vector2(rand_range(-1,1), rand_range(-1,1))

func _physics_process(delta):
	on_island = false
	time_to_change -= delta
	next_cloud -= delta
	
	for body in $Area2D.get_overlapping_bodies():
		if (body.is_in_group("Island")):
			on_island = true
	if (on_island):
		move_and_slide(current_direction*speed)
	else:
		current_direction = current_direction.rotated(PI)
		move_and_slide(current_direction*speed*2)
	
	if (time_to_change <= 0):
		change_direction()
		time_to_change = rand_range(2,6)
		
	if (next_cloud <= 0 && Config.weather != null):
		$Particles2D.emitting = true
		Config.weather.generate_cloud(self.position, current_direction)	
		next_cloud = rand_range(10,30)
	