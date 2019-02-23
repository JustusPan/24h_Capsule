extends Panel

func _ready():
	Engine.target_fps = 60
	
func _process(delta):
	var fps = Engine.get_frames_per_second()
	$Number.text = str(fps)
	pass
