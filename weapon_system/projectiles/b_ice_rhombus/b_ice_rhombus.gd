extends RigidBody2D

const MAX_SPEED = 100

var owner_name = "NONE"
onready var is_valid = true

func launch(direction,speed,launcher):
	self.rotate_forward_direction_to(direction)
	self.linear_velocity = direction.normalized() * speed
	self.add_collision_exception_with(launcher) # don't want player to collide with bullet
	pass
	
func _ready():
	var render_target_texture = $pixel_perfect_rotation/Viewport.get_texture()
	$Sprite.set_texture(render_target_texture)
	$Sprite.centered = true
	
	#debug_justus
	#$pixel_perfect_rotation/Viewport/original_sprite.set_rotation(0)
	pass
	
func rotate_forward_direction_to(new_forward_direction):
	$pixel_perfect_rotation/Viewport/original_sprite.look_at(new_forward_direction)
	$Area2D.look_at(new_forward_direction)
	var ang = new_forward_direction.angle()
	$pixel_perfect_rotation/Viewport/original_sprite.set_rotation(ang - PI/2.0)# depends on default direction of assets
	$Area2D.set_rotation(ang - PI/2.0)
	
#	print("rotate_forward_direction_to ang = ",ang)
#	print("rotate_forward_direction_to  original_sprite.rotation= ",$pixel_perfect_rotation/Viewport/original_sprite.rotation)
#	print("rotate_forward_direction_to $Area2D.rotation = ",$Area2D.rotation)
	pass
	
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
			is_valid = false
			body.call("hit_by_bullet",owner_name)
		$anim.play("delete_bullet")

