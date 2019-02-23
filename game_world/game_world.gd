extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#ngine.target_fps = 60
	init_game()
	
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		global_manager.save_game()
		SceneMgrAL.goto_scene("res://ui_design/main_menu/MainMenu.tscn")

	pass

func init_game(): 
#	global_var.score = 0
	global_manager.connect("score_changed",self,"on_score_changed")
	global_manager.connect("high_score_changed",self,"on_high_score_changed")
	util_lib.connect("game_over",self, "on_game_over")
	
	$HUD/HighScore.text = str("High Score: ") + str(global_manager.high_score)
	
	#init objects position
	$CameraMount.global_position = $Spaceship.global_position

func restart_game():
	print("restart_game")
#	get_tree().reload_current_scene()
	SceneMgrAL.goto_scene("res://game_world/game_world.tscn")
	get_tree().paused = false
	
	#.reload_scene_from_path("./game_world.tscn")
	pass

func on_score_changed(new_score):
	$HUD/ScoreBoard.text = str("Score: ") + str(new_score)


func on_high_score_changed(new_high_score):
	$HUD/HighScore.text = str("High Score: ") + str(new_high_score)
	pass
	
	
func on_game_over():
	$worldAnim.play("you_died")
	util_lib.pause_game()
	global_manager.save_game()
	pass
	