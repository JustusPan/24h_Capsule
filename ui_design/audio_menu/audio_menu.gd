extends Panel

const MIN_db = -80
const MAX_db = -20

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		self.hide()
	pass

func _on_music_value_changed(value):
	print("music: ",value)
	var music_nodes = get_tree().get_nodes_in_group("Music")
	for i in music_nodes:
		i.volume_db = MIN_db + value/100.0 * (MAX_db - MIN_db)
	pass # replace with function body


func _on_SFX_value_changed(value):
	print("SFX: ",value)
	var SFX_nodes = get_tree().get_nodes_in_group("SFX")
	for i in SFX_nodes:
		i.volume_db = MIN_db + value/100.0 * (MAX_db - MIN_db)
	pass # replace with function body


func _on_all_value_changed(value):
	print("All: ",value)
	print("min: ",MIN_db)
	print("max: ",MAX_db)
	#var new_volume = MIN_db + value/100.0 * (MAX_db - MIN_db)
	#print("All: new_volume = ", new_volume)
	var new_volume_db = 10 * log(value/100.0) + MAX_db
	print("All: new_volume_db = ", new_volume_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), new_volume_db)
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	pass # replace with function body
