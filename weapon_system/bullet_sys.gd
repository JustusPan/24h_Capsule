extends "weapon_config.gd"

var last_shoot_elapsed_time
var pressing_time

func custom_reset(cur_weapon):
	last_shoot_elapsed_time = 0
	pressing_time = 0
	
func custom_physics_process(delta, cur_weapon):
	last_shoot_elapsed_time += delta
	if Input.is_action_just_pressed(trigger_name) && weapon_single_shot[cur_weapon]:
		if last_shoot_elapsed_time > weapon_fusillade[cur_weapon]:
			last_shoot_elapsed_time = 0
			trigger_pressed(cur_weapon)

	if Input.is_action_pressed(trigger_name):
		pressing_time += delta
		trigger_pressing_process(cur_weapon,pressing_time);
	else:
		pressing_time = 0
		
#	blowback_cooling(cur_weapon, delta)
	pass

func trigger_pressed(cur_weapon):
	generate_bullet(cur_weapon)
	#print("weapon_system::trigger_pressed")
	pass
	
func trigger_pressing_process(cur_weapon,pressing_time):
	if last_shoot_elapsed_time > weapon_fusillade[cur_weapon] && pressing_time > weapon_fusillade_delay[cur_weapon]:
		last_shoot_elapsed_time = 0
		generate_bullet(cur_weapon)
		#print("bullet_sys::trigger_pressing::pressed_time = ",pressing_time)
	pass
	
func generate_bullet(cur_weapon):
	# get scattering params
	var parallel_count = weapon_scattering[cur_weapon].count
	if parallel_count == 0: return
	var total_scattering_radian = deg2rad(weapon_scattering[cur_weapon].degree)
	var interval_radian = 0 if parallel_count == 1 else total_scattering_radian * 1.0 /(parallel_count - 1)
	var is_random = weapon_scattering[cur_weapon].is_random
	
	
	var dir_vector = (to_ref.global_position - from_ref.global_position).normalized()
	var next_vector = dir_vector.rotated(-total_scattering_radian/2.0)
	for i in range(parallel_count):
		#print("i = ",i)
		var bullet = weapon_dict[cur_weapon].instance()
		bullet.position = from_ref.global_position
		
		if is_random:
			var rand_vector = dir_vector.rotated(rand_range(-total_scattering_radian/2.0,total_scattering_radian/2.0))
			bullet.launch(rand_vector,bullet.MAX_SPEED,local_ref)
		else:
			bullet.launch(next_vector,bullet.MAX_SPEED,local_ref)
			next_vector = next_vector.rotated(interval_radian)
		
		local_ref.get_parent().add_child(bullet) #don't want bullet to move with me, so add it as child of parent
	
func getRandomPoint(center,radius):
	var a = rand_range(0,radius) * 2 * PI
	var r = radius * sqrt(rand_range(0,1))
	var x = r * cos(a)
	var y = r * sin(a)
	return Vector2(x,y) + center