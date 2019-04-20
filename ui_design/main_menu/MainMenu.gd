extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#$MarginContainer/HBoxContainer/CenterContainer/HBoxContainer/HighScore.text = "High Score: " + String(get_node("/root/global").get_meta("high_score"))
#	$MarginContainer/HBoxContainer/CenterContainer/HBoxContainer/HighScore.text = "High Score: NULL"

	if OS.get_name() == "HTML5":
		$"MarginContainer/VBoxContainer/MenuOptions/Exit".visible = false
	pass

func _physics_process(delta):
	#Input.is_key_pressed(KEY_MASK_CTRL) and Input.is_key_pressed(KEY_MASK_SHIFT) and 
	if Input.is_key_pressed(KEY_A) and Input.is_key_pressed(KEY_B) and Input.is_key_pressed(KEY_C) and Input.is_key_pressed(KEY_P):
		global_manager.erase_save_data()
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
	if OS.get_name() != "HTML5":
		get_tree().quit()
	pass # replace with function body


