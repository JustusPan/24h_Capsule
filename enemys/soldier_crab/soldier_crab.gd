extends KinematicBody2D

signal text_effect_triggered(pos,string)

#onready var magic_db_ref = get_node("/root/magic_db")

# Member variables
const MODE_DIRECT = 0
const MODE_CONSTANT = 1
const MODE_SMOOTH = 2

const ROTATION_SPEED = 1
const SMOOTH_SPEED = 2.0

export(int, "Direct", "Constant", "Smooth") var mode = MODE_DIRECT

#world info
const FLOOR_NORMAL = Vector2(0,0) # (0,0) for top-down game

#character info
const VEL_MAGNITUDE = 20
const HP_MAX = 10
const BLOWBACK_MAX = 40
var velocity = Vector2(0,0)
var hp = 10
onready var is_alive = true

export(NodePath) var nav_path
export(NodePath) var attack_target_path
var nav_ref
var attack_target

var tracing_route = []

func _process(delta):
	pass
	
func _physics_process(delta):
	#update_route()
	var to_position
	if attack_target == null:
		to_position = get_global_mouse_position()
	else:
		to_position = attack_target.global_position
	
	if tracing_route.size() != 0:
		print(tracing_route) #debug_justus
		if tracing_route.size() > 1:
			if self.global_position.distance_to(tracing_route[0]) < 2:
				tracing_route.remove(0)
		to_position = tracing_route[0]
		
	velocity = (to_position - global_position).normalized() * VEL_MAGNITUDE
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func _input(event):
	pass
	
#func getRandomPoint(center,radius):
#	var a = rand_range(0,radius) * 2 * PI
#	var r = radius * sqrt(rand_range(0,1))
#
#	var x = r * cos(a)
#	var y = r * sin(a)
#	return Vector2(x,y) + center
	
func init(newTarget, newNav):
	attack_target = newTarget
	nav_ref = newNav
	#update_route()
	pass

func _ready():
	set_meta("tag","enemy")
	if attack_target_path != null:
		attack_target = get_node(attack_target_path)
	if nav_path != null:
		nav_ref = get_node(nav_path)
	
	set_process(true)
	set_physics_process(true)
	set_process_input(true)
	
func update_route():
	tracing_route = nav_ref.get_simple_path(self.global_position, attack_target.global_position,false)
	#print("update_route tracing_route = ",tracing_route)
	pass
	
func hit_by_bullet(fromWhom,damage):
	if not is_alive:
		return
#	var fx = bloodyFX.instance()
#	add_child(fx)
#	fx.restart()
	var damage_value = damage
	hp -= damage_value
	#emit_signal("text_effect_triggered",self.get_canvas_transform().origin + self.global_position,str(damage_value)) # for canvas condition
	#emit_signal("text_effect_triggered",self.global_position,str(damage_value))
	util_lib.emit_signal("local_text_popup_FX_triggered",self, Vector2(0,0), str(damage_value))
	#util_lib.emit_signal("text_popup_FX_triggered", self.global_position, str(damage_value))
	if hp <= 0 and is_alive: 
		is_alive = false
		print("killed by ",fromWhom)
		increaseScore(1)
		
		# dead particle FX
#		var fx = bloodyFX.instance()
#		add_child(fx)
#		fx.restart()
		
		$controlAnim.play("Dead")
	#print("hit_by_bullet")
	pass
	
#func hit_by_laser(fromWhom):
#	if not is_alive:
#		return
##	var fx = bloodyFX.instance()
##	add_child(fx)
##	fx.restart()
#	hp -= 200
#	if hp < 0: 
#		is_alive = false
#		print("laser::killed by ",fromWhom)
#		increaseScore(1)
#
#		# dead particle FX
#		var fx = bloodyFX.instance()
#		add_child(fx)
#		fx.restart()
#
#		$controlAnim.play("Dead")
#	pass
	
func increaseScore(value):
	var global_var = get_node("/root/global_manager")
	global_var.score += value
	print("score = ", global_var.score) #debug_justus
	#global_var.set_meta("score",global_var.get_meta("score") + value)

func _on_random_timer_timeout():
	update_route()
	pass # replace with function body


func _on_Area2D_body_entered(body):
	if body.has_method("hurt_by_enemy"):
		body.call("hurt_by_enemy")
	pass # Replace with function body.
