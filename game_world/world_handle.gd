extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	var host = get_node("..")
	if get_tree().paused and not host.get_node("worldAnim").is_playing() and event is InputEventKey:
		get_node("..").restart_game()