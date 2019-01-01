extends Node2D

const Pool = preload("text_anim/S1_text_smooth/TimePool.gd")
const text = preload("text_anim/S1_text_smooth/popup_text_by_anim.tscn")

const POOL_SIZE = 100
const POOL_PREFIX = "text_anim"

onready var texts = $Texts
onready var textPool = Pool.new(POOL_SIZE,POOL_PREFIX,text)

func _ready():
	textPool.connect("killed", self, "_on_pool_killed")
	# connect global signal
	util_lib.connect("text_popup_FX_triggered", self, "on_text_popup_FX")
	util_lib.connect("local_text_popup_FX_triggered", self, "on_local_text_popup_FX")
	
func _on_pool_killed(target):
	target.hide()

func on_text_popup_FX(pos,string):
	var textInstance = textPool.create()
	if not texts.is_a_parent_of(textInstance):
		texts.add_child(textInstance)	
	textInstance.start(pos,string,Color(1,1,1))


func on_local_text_popup_FX(target, pos, string):
	if not util_lib.is_object_valid(target):
		return
		
	var textInstance = textPool.create()
	if texts.is_a_parent_of(textInstance):
		texts.remove_child(textInstance)
	if not target.is_a_parent_of(textInstance):
		target.add_child(textInstance)	
	textInstance.start_local(pos,string,Color(1,1,1))