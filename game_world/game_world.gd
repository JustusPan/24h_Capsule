extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.target_fps = 60
	init_game()
	
	#debug for loader
	for i in range(1000000000):
		pass
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneMgrAL.goto_scene("res://ui_design/main_menu/MainMenu.tscn")

	pass

func init_game(): 
	var global_var = get_node("/root/global_manager")
	global_var.score = 0
	global_var.connect("score_changed",self,"on_score_changed")
	util_lib.connect("game_over",self, "on_game_over")

func restart_game():
	print("restart_game")
#	get_tree().reload_current_scene()
	SceneMgrAL.goto_scene("res://game_world/game_world.tscn")
	get_tree().paused = false
	
	#.reload_scene_from_path("./game_world.tscn")
	pass

func on_score_changed(new_score):
	$HUD/ScoreBoard.text = str("Score: ") + str(new_score)
	
func on_game_over():
	$worldAnim.play("you_died")
	util_lib.pause_game()
	pass
	