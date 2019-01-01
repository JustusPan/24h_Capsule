extends Node

signal text_popup_FX_triggered(pos,string)
signal local_text_popup_FX_triggered(target,pos,string)
signal game_over()
#func _ready():
##	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
#	print('util_lib loaded')
#	print('is joy known = ',is_joy_connected(0))
#
##for test
#func _physics_process(delta):
#	var axis_value_x = Input.get_joy_axis(0, JOY_AXIS_0)
#	var axis_value_y = Input.get_joy_axis(0, JOY_AXIS_1)
#	print(axis_value_x,axis_value_y)
#	pass
#func _on_joy_connection_changed(device_id, connected):
#	print(device_id,connected)
#	if connected:
#		print(Input.get_joy_name(device_id))
#	else:
#		print("Keyboard")

# global operation
func pause_game():
	get_tree().paused = true

# gameplay helper
func is_allied(a, b):
	assert("AllyGroup" in a and "AllyGroup" in b)
	return a.AllyGroup == b.AllyGroup


#---------
# func set_debug_mode(value):
# 	if debug_mode != value:
# 		debug_mode = value
# 		emit_signal("debug_mode_changed", value)


func is_object_valid(object):	
	return object and weakref(object).get_ref()


#math helper
func one_in(number): # probability 1/number
	return randi() % number == 0


func get_randi_range(lower_bound,upper_bound):
	if upper_bound < lower_bound:
		return lower_bound
	var delta = upper_bound - lower_bound
	return randi()%(delta + 1) + lower_bound