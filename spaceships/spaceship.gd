extends KinematicBody2D
#signal healthPointchanged(value)
#signal toNextWeapon()
#signal dead()

# Member variables
const MODE_DIRECT = 0
const MODE_CONSTANT = 1
const MODE_SMOOTH = 2

const ROTATION_SPEED = 1
const SMOOTH_SPEED = 2.0

#look-at mode
export(int, "Direct", "Constant", "Smooth") var mode = MODE_DIRECT

#world info
const FLOOR_NORMAL = Vector2(0,0) # (0,0) for top-down game

#character info
const VEL_MAGNITUDE = 200
#const HP_MAX = 100
#var hp = 100

var m_motion_input = Vector2(0,0)
	
func _physics_process(delta):
	#var mpos = get_viewport().get_mouse_position()
	var mpos = get_global_mouse_position()
	
	if (mode == MODE_DIRECT):
		look_at(mpos)
	elif (mode == MODE_CONSTANT):
		var ang = get_angle_to(mpos)
		var s = sign(ang)
		ang = abs(ang)
		
		rotate(min(ang, ROTATION_SPEED*delta)*s)
	elif (mode == MODE_SMOOTH):
		var ang = get_angle_to(mpos)
		rotate(ang*delta*SMOOTH_SPEED)
		
	m_motion_input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	m_motion_input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_and_slide(m_motion_input * VEL_MAGNITUDE, FLOOR_NORMAL)
	
#func _input(event):
#	if event.is_action_pressed("next_weapon"):
#		emit_signal("toNextWeapon")
#	pass

#func _input(event):
#	# handle motion input
##	m_motion_input = Vector2(0,0)
	

	
#func hurt_by_enemy():
#	if (hp < 0):
#		return
#	print("hurt_by_enemy")
#	hp -= 3
#	emit_signal("healthPointchanged",hp)
#	if (hp < 0):
#		#$controlAnim.play("dead")
#		emit_signal("dead")
#	pass


#func _on_hitBox_body_entered(body):
##	if body.get_meta("tag") == "enemy":
##		hurt_by_enemy()
#	pass # replace with function body