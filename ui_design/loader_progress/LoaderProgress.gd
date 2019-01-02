extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$MarginContainer/ProgressBar.value = 0
	set_process_input(true)
	pass

func set_progress(new_value):
	$MarginContainer/ProgressBar.value = new_value
	var length = $MarginContainer/ProgressBar.max_value - $MarginContainer/ProgressBar.min_value
	$MarginContainer/ProgressBar.value = $MarginContainer/ProgressBar.min_value + new_value * length
	pass

func _input(event):
	if event.is_action_pressed("ui_right"):
		$MarginContainer/ProgressBar.value += 1
	pass