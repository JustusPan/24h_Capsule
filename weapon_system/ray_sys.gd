extends "weapon_config.gd"

var ray_singleton = b_laser.instance()

func shut_down():
	disable_ray()
	pass

func custom_reset(cur_weapon):
	pass
	
func custom_physics_process(delta, cur_weapon):
	if Input.is_action_pressed(trigger_name):
		enable_ray()
	else:
		disable_ray()
	pass
	
func enable_ray():
	from_ref.add_child(ray_singleton)
	ray_singleton.enable_ray()
	pass
	
func disable_ray():
	from_ref.remove_child(ray_singleton)
	ray_singleton.disable_ray()
	pass