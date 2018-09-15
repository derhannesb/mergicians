extends Node2D	

var trapped = Array()

var max_energy = 100.0
var energy = max_energy
var energy_per_push = 0.25

export var inner_radius = 20
export var outer_radius = 1000 

func _ready():
	var circle = CircleShape2D.new()
	$Area2D/C2DInner.shape = circle
	$Area2D/C2DInner.shape.radius = inner_radius

	circle = CircleShape2D.new()
	$Area2D/C2DOuter.shape = circle
	$Area2D/C2DOuter.shape.radius = outer_radius
	
func _physics_process(delta):
	for body in trapped:
		var distance = body.global_position.distance_to(global_position)
		if (distance <= inner_radius):
			#push boat around:
			var position_difference = global_position - body.global_position
			var normalized_difference = position_difference.normalized()
	
			body.apply_impulse(Vector2(0,0), normalized_difference*(inner_radius+60-distance ))
			
		else:
			#push energy to boat:
			body.push_energy(energy_per_push)
			energy -= energy_per_push
			if (energy < 0):
				energy = 0
				body.exit_storm()
	modulate = Color(1,1,1,energy/max_energy)

	if (energy == 0):
		self.queue_free()	
			
func _on_Area2D_body_entered(body):
	if (body.is_in_group("ship")):
		var distance = body.global_position.distance_to(global_position)
		body.enter_storm(self)
		trapped.push_front(body)
	
func _on_Area2D_body_exited(body):
	if (body.is_in_group("ship")):
		body.exit_storm()
		trapped.remove(trapped.find(body))