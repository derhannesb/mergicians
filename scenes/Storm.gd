extends Node2D	

var trapped = Array()

func _ready():
	pass

func _physics_process(delta):
	for body in trapped:
		var position_difference = global_position - body.global_position
		var normalized_difference = position_difference.normalized()
		var distance = body.global_position.distance_to(global_position)
		body.apply_impulse(Vector2(0,0), normalized_difference*(180-distance ))

func _on_Area2D_body_entered(body):
	var distance = body.global_position.distance_to(global_position)
	print(distance)
	trapped.push_front(body)
	
func _on_Area2D_body_exited(body):
	trapped.remove(trapped.find(body))