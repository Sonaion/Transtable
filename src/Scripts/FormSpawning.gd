extends Node2D


export(Array, Resource) var forms = []
var all_forms = []
var rng = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rng = RandomNumberGenerator.new()
	self.rng.seed = hash(OS.get_time())
	$Timer.connect("timeout", self, "spawn_element")
	spawn_element()
	

func set_timer(time, should_delete):
	if should_delete:
		remove_child(all_forms[-1])
		all_forms.erase(all_forms[-1])
	$Timer.start(time)
	$Timer.one_shot = true

	
		
func spawn_element():
	var rand_index = self.rng.randi() % forms.size() 
	var scene = forms[rand_index]
	var form = scene.instance()
	form.init(
		Vector2(160.0, -100.0), 	#position
		180,					#max speed
		1.00,					#time to stop
		1.0,					#mass
		1.0,					#gravity scale
		0.0,					#angular velocity
		0.0,					#y_impulse
		0.0						#rotation
	)
	add_child(form)
	all_forms.append(form)
	form.connect("lost_control", self, "set_timer")
	

	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
