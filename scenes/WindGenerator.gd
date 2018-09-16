extends Node2D

const strength_factor = 1250
const decay_factor = 20

export var energy = 100
export var initial_strength = 0.01
var strength = energy / strength_factor
var energy_step = 0
var generated_by = null

func _ready():
	pass

func _physics_process(delta):
	if (energy > 0):
		energy -= delta*decay_factor
	if (energy < 0):
		self.queue_free()
	strength = energy / strength_factor
	$Particles2D.modulate = Color(1,1,1,energy/100)

	#$Particles2D.process_material.initial_velocity = energy
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if (collider != null):
			if (collider.is_in_group("ship")):
				collider.apply_impulse(Vector2(0,0), $Target.position.rotated(rotation)*strength)
			
			if (collider.is_in_group("windmill")):
				collider.get_parent().blow(strength)
				generated_by.increase_score(1)
			
			if (collider.is_in_group("evilwizard")):
				collider.increase_damage(-strength*10)
				generated_by.increase_score(1)	