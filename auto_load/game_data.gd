extends Node

var score = 0 setget set_score
signal score_changed(new_score)
# Called when the node enters the scene tree for the first time.

func set_score(new_score):
	score = new_score
	emit_signal("score_changed",score)

	
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

