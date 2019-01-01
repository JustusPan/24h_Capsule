extends Node2D

#pool interface
signal killed(target)

onready var __mount = self
onready var __label = $Label
onready var __tween = $Tween

var __label_position = Vector2(0,0)
var __label_size = 0

const __ANIM_DURATION = 0.5
const __INIT_OFFSET = Vector2(0, -5)
const __JUMP_OFFSET = Vector2(0, -10)
const __INIT_SCALE = Vector2(0.2,0.2)
const __DELTA_SCALE = Vector2(1,1)

func start(pos = Vector2(100,100),newText = "test label",color = Color(1,1,1)):
	#self.global_position = pos
	__label.text = newText
	var x_offset = __label.rect_size.x/2
	var y_offset = __label.rect_size.y/2
	__label.rect_position = Vector2(-x_offset,-y_offset)
	# init label size,pos,color
	__label.set("custom_colors/font_color", color)
	
	var start_pos = pos + __INIT_OFFSET
	var end_pos = start_pos + __JUMP_OFFSET
	
	__tween.interpolate_property(self,"global_position",start_pos,end_pos, __ANIM_DURATION, Tween.TRANS_QUINT, Tween.EASE_OUT)
	#__tween.interpolate_property(__label.get("custom_fonts/font"),"size",__INIT_SIZE,__INIT_SIZE + __DELTA_SIZE, __ANIM_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	__tween.interpolate_property(self,"scale",__INIT_SCALE,__INIT_SCALE + __DELTA_SCALE, __ANIM_DURATION, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__tween.interpolate_callback(self,__ANIM_DURATION, "__my_free_callback")
	__tween.start()
	
	set_process(true)
	self.visible = true
	
func start_local(pos = Vector2(100,100),newText = "test label",color = Color(1,1,1)):
	#self.global_position = pos
	__label.text = newText
	var x_offset = __label.rect_size.x/2
	var y_offset = __label.rect_size.y/2
	__label.rect_position = Vector2(-x_offset,-y_offset)
	# init label size,pos,color
	__label.set("custom_colors/font_color", color)
	
	var start_pos = pos + __INIT_OFFSET
	var end_pos = start_pos + __JUMP_OFFSET
	
	__tween.interpolate_property(self,"position",start_pos,end_pos, __ANIM_DURATION, Tween.TRANS_QUINT, Tween.EASE_OUT)
	#__tween.interpolate_property(__label.get("custom_fonts/font"),"size",__INIT_SIZE,__INIT_SIZE + __DELTA_SIZE, __ANIM_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	__tween.interpolate_property(self,"scale",__INIT_SCALE,__INIT_SCALE + __DELTA_SCALE, __ANIM_DURATION, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__tween.interpolate_callback(self,__ANIM_DURATION, "__my_free_callback")
	__tween.start()
	
	set_process(true)
	self.visible = true

func stop():
	__tween.stop_all()
	
	set_process(false)
	self.visible = false

func _enter_tree():
	#print("enter tree!")
	self.visible = false

#func _exit_tree():
#	print("exit tree!")
	
# private
func __my_free_callback():
	self.stop()
	emit_signal("killed",self)
#	queue_free()