extends RigidBody2D

const MAX_SPEED = 3000

var owner_name = "NONE"
onready var is_valid = true

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
	print("_on_bullet_1_body_entered")
	if is_valid:
		is_valid = false
		if body.has_method("hit_by_bullet"):
			body.call("hit_by_bullet",owner_name)
		$anim.play("delete_bullet")