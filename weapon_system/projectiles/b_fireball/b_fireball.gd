extends RigidBody2D

const MAX_SPEED = 500

var owner_name = "NONE"
var magic_id = 10002
onready var is_valid = true
onready var remain_collision_count = 3

func launch(direction,speed,launcher):
	self.linear_velocity = direction.normalized() * speed
	self.add_collision_exception_with(launcher) # don't want player to collide with bullet
	pass
	
func set_owner(new_owner_name):
	owner_name = new_owner_name

func _on_Timer_timeout():
	if is_valid:
		is_valid = false
		$anim.play("delete_bullet")


func _on_Area2D_body_entered(body):
	#print("_on_Area2D_body_entered")
	if is_valid and remain_collision_count > 0:
		if body.has_method("hit_by_bullet"):
			is_valid = false
			body.call("hit_by_bullet",owner_name,magic_id)
			$anim.play("delete_bullet")
			return
			
		remain_collision_count = remain_collision_count - 1
		if remain_collision_count <= 0:
			$anim.play("delete_bullet")
			return

