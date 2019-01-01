extends Node2D

onready var __mount = self
onready var __label = $Label
onready var __tween = $Tween

var __label_position = Vector2(0,0)
var __label_size = 0

const __ANIM_DURATION = 3.0
const __JUMP_OFFSET = Vector2(0,-100)
const __INIT_SIZE = 20
const __DELTA_SIZE = 25

func start(pos = Vector2(100,100),newText = "test label",color = Color(1,1,1)):
	self.global_position = pos
	__label.text = newText
	var x_offset = __label.rect_size.x/2
	var y_offset = __label.rect_size.y/2
	var start_pos = Vector2(-x_offset,-y_offset)
	var end_pos = start_pos + __JUMP_OFFSET
	
	# init label size,pos,color
	__label.set("custom_colors/font_color", color)
	__label.rect_position = start_pos # init center label
	__label.get("custom_fonts/font").set("size",__INIT_SIZE)
	
	__tween.interpolate_property(self,"__label_position",start_pos,end_pos, __ANIM_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	#__tween.interpolate_property(self,"__label_size",__INIT_SIZE,__INIT_SIZE + __DELTA_SIZE, __ANIM_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	__tween.interpolate_property(__label.get("custom_fonts/font"),"size",__INIT_SIZE,__INIT_SIZE + __DELTA_SIZE, __ANIM_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	__tween.interpolate_callback(self,__ANIM_DURATION, "__my_free_callback")
	__tween.start()
	
	self.visible = true
	set_process(true)
	
func _ready():
	#start(str(__display_text))
	self.visible = false
	set_process(false)

func _process(delta):
	__label.rect_position = __label_position
	#__label.get("custom_fonts/font").set("size",__label_size)
	
# private
func __my_free_callback():
	self.visible = false
	queue_free()