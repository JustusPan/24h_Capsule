extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

		
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		for i in range(1):
			var global_pos = $TextPopupFX.get_global_mouse_position()
			print(global_pos) #debug_justus
			var global_pos_dummy = global_pos# + Vector2(i*10,i*-10)
			util_lib.emit_signal("text_popup_FX_triggered",global_pos_dummy,str(global_pos_dummy))