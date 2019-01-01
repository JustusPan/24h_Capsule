extends Position2D

export(NodePath) var nav_path
export(NodePath) var target_path
export(NodePath) var mount_path

var navigation_ref
var target
var mount_point

export(PackedScene) var instance_scene

export(float) var spawn_interval

var timer = 0

func _ready():
	navigation_ref = get_node(nav_path)
	target = get_node(target_path)
	mount_point = get_node(mount_path)
	
	set_process(true)

func _process(delta):
	timer+=delta
	if timer > spawn_interval:
		timer = 0
		var cur = instance_scene.instance()
		cur.init(target,navigation_ref)

		cur.global_position = self.global_position
		mount_point.add_child(cur)
	pass
