extends Node

#signals
signal weaponChanged(weapon_name)

export(NodePath) var global_node_path
export(NodePath) var local_node_path
export(NodePath) var from_path # refactor_justus
export(NodePath) var to_path # refactor_justus

export(String) var trigger_name

onready var global_ref = get_node(global_node_path)
onready var local_ref = get_node(local_node_path)
onready var from_ref = get_node(from_path)
onready var to_ref = get_node(to_path)
onready var params = {
	"global_ref":global_ref,
	"local_ref":local_ref,
	"from_ref":from_ref,
	"to_ref":to_ref,
	"trigger_name":trigger_name
}

#var order_list = ["windblade","icerhombuspd","fireball","laser"]
var order_list = ["windblade","icerhombuspd","fireball","rifle"]
onready var sub_system = {
	"windblade": $bullet_sys,
	"icerhombuspd": $bullet_sys,
#	"icerhombus": $bullet_sys,
	"rifle": $bullet_sys,
	"fireball": $bullet_sys,
	"laser": $ray_sys
}

#parameter related to current weapon
var cur_weapon

var m_tag = "weapon_sys"


#pulic API
func switch_weapon_to(new_weapon_name):
	#clear old system
	if cur_weapon != null and sub_system[cur_weapon].has_method("shut_down"):
		sub_system[cur_weapon].shut_down()
		
	#config new system
	cur_weapon = new_weapon_name
	sub_system[cur_weapon].init_params(params)
	sub_system[cur_weapon].custom_reset(cur_weapon)
		
	emit_signal("weaponChanged",cur_weapon)
	pass

func toNextWeapon():
	var next_weapon = "none"
	for i in range(order_list.size()):
		if (order_list[i] == cur_weapon):
			next_weapon = order_list[0] if i==order_list.size()-1 else order_list[i+1]
			break
	switch_weapon_to(next_weapon)
	
# override

func _ready():
	switch_weapon_to("windblade")
	set_physics_process(true)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("next_weapon"):
		self.toNextWeapon()

func _physics_process(delta):
	sub_system[cur_weapon].custom_physics_process(delta, cur_weapon)