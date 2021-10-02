extends RigidBody2D


const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 120
var is_moveable = true
var has_moved = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if self.has_moved and self.linear_velocity[1] <= 0.1:
		self.is_moveable = false
	if self.linear_velocity[1] > 0.1:
		self.has_moved = true
	if self.is_moveable:
		self.has_moved = true
		var motion = Vector2()
		if Input.is_action_just_pressed("left"):
			motion.x = -MAXSPEED
		if Input.is_action_just_pressed("right"):
			motion.x = +MAXSPEED

		apply_central_impulse(motion)
	
