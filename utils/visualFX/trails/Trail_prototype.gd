extends Line2D
var target
var point

enum trailMode {STRAIGHT_LINE, POLY_LINE}

export(NodePath) var targetPath
export var trailLength = 0
export(bool) var isInfinite = true
export(trailMode) var trail_mode = trailMode.STRAIGHT_LINE



func _ready():
	target = get_node(targetPath)
	pass

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = target.global_position
	#point = self.get_global_mouse_position() #debug_justus
	#print(point)
	match trail_mode:
		trailMode.STRAIGHT_LINE:
			var pointCount = get_point_count()
			
			if pointCount > 1:
				remove_point(pointCount-1)
				add_point(point)
			else:
				add_point(point)
			pass
		trailMode.POLY_LINE:
			add_point(point)
			
			pass
		_:
			pass
			
	if !isInfinite:
		while get_point_count() > trailLength:
			remove_point(0)
	pass
