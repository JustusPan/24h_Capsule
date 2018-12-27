extends Node

var global_ref
var local_ref
var from_ref
var to_ref
var trigger_name

func init_params(params):
	global_ref = params.global_ref
	local_ref = params.local_ref
	from_ref = params.from_ref
	to_ref = params.to_ref
	trigger_name = params.trigger_name
	pass

var b_pistol = preload("./projectiles/b_pistol/b_pistol.tscn")
var b_laser = preload("./projectiles/b_laser/b_laser.tscn")
var b_fireball = preload("./projectiles/b_fireball/b_fireball.tscn")
#var b_icerhombus = preload("res://bullets/b_ice_rhombus/b_ice_rhombus.tscn")
var b_icerhombus_pd = preload("./projectiles/b_ice_rhombus_predefined_direction/b_ice_rhombus_predefined_direction.tscn") # pd: predefined direction
var b_windblade = preload("./projectiles/b_wind_blade/b_wind_blade.tscn")

var weapon_dict = {
	"windblade": b_windblade,
	"icerhombuspd": b_icerhombus_pd,
	"rifle": b_pistol,
	#"icerhombus": b_icerhombus,
	"fireball": b_fireball,
	
}

var weapon_phy_tag = {
	"windblade": "rigid_body",
	"icerhombuspd": "rigid_body",
	"rifle": "rigid_body",
#	"icerhombus": "rigid_body",
	"fireball": "rigid_body"
}

var weapon_single_shot = {
	"windblade": true,
	"icerhombuspd": true,
	"rifle": true,
#	"icerhombus": true,
	"fireball": true
}

var weapon_fusillade = {
	"windblade": 0.5,
	"icerhombuspd": 0.02,
	"rifle": 0.02,
#	"icerhombus": 0.2,
	"fireball": 0.02
}

var weapon_fusillade_delay = {
	"windblade": 0,
	"icerhombuspd": 0,
	"rifle": 0,
#	"icerhombus": 0,
	"fireball": 0
#	"machinegun": 0.5,

}

#scattering mode & sector angle
var weapon_scattering = {
	"windblade": {
		"degree": 60,
		"count": 5,
		"is_random": false
	},
	"icerhombuspd": {
		"degree": 0,
		"count": 1,
		"is_random": false
	},
	"rifle": {
		"degree": 0,
		"count": 1,
		"is_random": false
	},
	"fireball": {
		"degree": 60,
		"count": 1,
		"is_random": true
	}
}