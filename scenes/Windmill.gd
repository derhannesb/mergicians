extends Node2D

var max_energy = 100
var energy = 0

func _ready():
	pass
	
func _process(delta):
	if (energy > 0):
		$AnimationPlayer.playback_speed = energy / max_energy * 20
		energy -= 0.25
	else:
		energy = 0
		$AnimationPlayer.playback_speed = 0

func blow(energy):
	print(self.energy)
	self.energy += energy*8
	