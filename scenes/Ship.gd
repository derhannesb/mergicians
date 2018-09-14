extends RigidBody2D

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		apply_impulse(Vector2(0,0), Vector2(0,-10))
	if Input.is_action_pressed("right"):
		apply_impulse(Vector2(0,0), Vector2(10,0))
	if Input.is_action_pressed("down"):
		apply_impulse(Vector2(0,0), Vector2(0,10))
	if Input.is_action_pressed("left"):
		apply_impulse(Vector2(0,0), Vector2(-10,0))
	