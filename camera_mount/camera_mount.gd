extends Position2D

export(NodePath) var target_path = null
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)
	target.connect("dead",self,"on_target_dead")


func _process(delta):
	global_position = target.global_position


func death_highlight():
	$MainCamera.limit_left = -100000
	$MainCamera.limit_right = 100000
	$MainCamera.limit_top = -100000
	$MainCamera.limit_bottom = 100000
	$AnimationPlayer.play("highlight")
	
	
func on_target_dead():
	death_highlight()
	pass