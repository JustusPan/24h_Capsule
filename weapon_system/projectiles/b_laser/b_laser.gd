extends RayCast2D
signal hit_point(collider, point)

var owner_name = "NONE"

#physic data
onready var end_point = Vector2(0,0)

#hit interval
const HIT_INTERVAL = 0.5
onready var last_shoot_elapsed_time = HIT_INTERVAL
var last_hit_collider

func set_owner(new_owner_name):
	owner_name = new_owner_name

func enable_ray():
	set_physics_process(true)
	set_process(true)
	if !$laserAnim.is_playing():
		$laserAnim.play("laser_strech")
	pass
	
func disable_ray():
	set_physics_process(false)
	set_process(false)
	if $laserAnim.is_playing():
		$laserAnim.stop()
	pass
	
func _ready():
	print("b_laser:_ready")
	init_parameters()
	init_connections()
	set_physics_process(true)
	set_process(true)
	pass
	
func init_parameters():
	self.position = Vector2(0,0)
	$tail.position = Vector2(0,0)
	$head.position = Vector2(0,0)
	$body.position = Vector2(0,0)
	$body2.position = Vector2(0,0)
	
	pass
	
func init_connections():
	if not self.is_connected("hit_point", self, "hit_point_handle"):
		connect("hit_point", self, "hit_point_handle")
	pass

func _physics_process(delta):
	last_shoot_elapsed_time += delta
	
	end_point = Vector2(0,0)
	if self.is_colliding():
		end_point = to_local(self.get_collision_point())
		#if last_shoot_elapsed_time > HIT_INTERVAL or self.get_collider() != last_hit_collider:
		if last_shoot_elapsed_time > HIT_INTERVAL:
			last_shoot_elapsed_time = 0
			#last_hit_collider = self.get_collider()
			emit_signal("hit_point", self.get_collider(),end_point)
	else:
		end_point = self.cast_to
	
func _process(delta):
	var body_length = end_point.length()
	
	#update head position
	#$head.position = end_point
	$head.position = Vector2($head.position.x, body_length)
		
	#update body
	update_body($body,body_length)
	update_body($body2,body_length)
	pass

	
func update_body(body,length):
	#update position
	#body.position = ($tail.position + $head.position)/2.0 # bad visual effect
	body.position = Vector2(body.position.x, length/2.0)

	#update length
	var rect_start = body.region_rect.position
	var rect_end = body.region_rect.end
	var x = rect_start.x
	var y = rect_start.y
	var w = length
	var h = rect_end.y - rect_start.y
	body.region_rect = Rect2(x,y,w,h)
	pass

func hit_point_handle(collider, point):
	if (collider == null):
		return
	if collider.has_method("hit_by_laser"):
		collider.call("hit_by_laser",owner_name)
	#$anim.play("delete_bullet")
	print("colider = ",collider," hit_point1 = ",point)

