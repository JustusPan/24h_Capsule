extends Panel

func _process(delta):
	var fps = Engine.get_frames_per_second()
	$Number.text = str(fps)
	pass
