extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#$MarginContainer/HBoxContainer/CenterContainer/HBoxContainer/HighScore.text = "High Score: " + String(get_node("/root/global").get_meta("high_score"))
#	$MarginContainer/HBoxContainer/CenterContainer/HBoxContainer/HighScore.text = "High Score: NULL"
	pass

#func _on_NewGame_pressed():
#	print("NewGame Pressed")
#	#get_node("/root/global").goto_scene("res://arena/arena.tscn")
#	get_tree().paused = false
#	pass # replace with function body

func _on_Play_pressed():
	SceneMgrAL.goto_scene("res://game_world/game_world.tscn")
	pass # replace with function body
	

func _on_Options_pressed():
	print("Options Pressed")
	$audio_menu.show()
	pass # replace with function body


func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body


