extends RigidBody2D

const MAX_SPEED = 1000

var owner_name = "NONE"
var magic_id = 10000
onready var is_valid = true

func launch(direction,speed,launcher):
	#self.rotate_forward_direction_to(direction)
	self.linear_velocity = direction.normalized() * speed
	self.add_collision_exception_with(launcher) # don't want player to collide with bullet
	pass

func _ready():
	var rotation_index = randi() % 4 + 1
	var rotation_anim_name = str("rotating_") + str(rotation_index)
	$anim.play(rotation_anim_name)
	pass
	
#func rotate_forward_direction_to(new_forward_direction):
#	var ang = new_forward_direction.angle()
#	var frame_index = int(floor(12 * (ang + 1.5 * PI)/PI)) % 24
#	print("rotate_forward_direction_to frame_index = ",frame_index) #debug_justus
#	$Sprite.frame = frame_index
#	$Area2D.set_rotation(ang - PI/2.0)
	
#	print("rotate_forward_direction_to ang = ",ang)
#	print("rotate_forward_direction_to  original_sprite.rotation= ",$pixel_perfect_rotation/Viewport/original_sprite.rotation)
#	print("rotate_forward_direction_to $Area2D.rotation = ",$Area2D.rotation)
#	pass
	
func set_owner(new_owner_name):
	owner_name = new_owner_name

func _on_Timer_timeout():
	if is_valid:
		is_valid = false
		$anim.play("delete_bullet")


func _on_Area2D_body_entered(body):
	print("ice_rhombus::_on_Area2D_body_entered")
	if is_valid:
		if body.has_method("hit_by_bullet"):
			#is_valid = false
			body.call("hit_by_bullet",owner_name,magic_id)
		#$anim.play("delete_bullet")
