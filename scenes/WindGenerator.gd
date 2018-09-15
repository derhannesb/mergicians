extends Node2D

export var strength = 0.01

func _ready():
	pass

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if (collider.is_in_group("ship")):
			collider.apply_impulse(Vector2(0,0), $Target.position.rotated(rotation)*strength)
			