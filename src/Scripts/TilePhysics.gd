extends RigidBody2D


const UP = Vector2(0,-1)
export(int) var MAXSPEED = 120
export(bool) var is_moveable = true
export(bool) var has_moved = false
export(float) var time_to_stop = 1.0

signal lost_control(time_to_stop, should_despawn)
var sending = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func init(
	position,
	MAXSPEED=120,
	time_to_stop=1.0,
	mass=1.0,
	gravity_scale=1.0,
	angular_velocity = 0.0,
	y_impulse = 0.0,
	rotation = 0.0):
	self.transform.origin = position
	self.MAXSPEED = MAXSPEED
	self.time_to_stop = time_to_stop
	self.mass = mass
	self.weight = mass * 9.8
	self.gravity_scale = gravity_scale
	self.angular_velocity = angular_velocity
	self.linear_velocity = Vector2(0.0, y_impulse)
	self.rotation_degrees = rotation

func _physics_process(delta):
	if self.sending==false and ((self.has_moved and self.linear_velocity[1] <= 1.5) or (self.transform.origin[1] > 260.0)):
		sending=true
		self.is_moveable = false
		self.mass = self.mass*10.0
		self.weight = self.mass * 9.8
		emit_signal("lost_control", self.time_to_stop, self.transform.origin[1] > 260.0)
	if self.linear_velocity[1] > 0.8:
		self.has_moved = true
	if self.is_moveable:
		self.has_moved = true
		var motion = Vector2()
		if Input.is_action_pressed("left"):
			motion.x = -MAXSPEED
		if Input.is_action_pressed("right"):
			motion.x = +MAXSPEED

		self.linear_velocity[0] = motion.x
	
