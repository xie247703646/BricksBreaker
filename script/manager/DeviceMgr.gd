extends Node

const CONFIG_SECTION = "Device"

var vibrate_on:bool = true setget _set_vibrate_on,_get_vibrate_on

func _set_vibrate_on(v:bool)->void:
	vibrate_on = v
	ConfigMgr.set_value(CONFIG_SECTION,"vibrate",v)

func _get_vibrate_on()->bool:
	return vibrate_on

func _ready() -> void:
	if not ConfigMgr.has_section(CONFIG_SECTION):
		ConfigMgr.set_value(CONFIG_SECTION,"vibrate",true)
	else:
		vibrate_on = ConfigMgr.get_value(CONFIG_SECTION,"vibrate")

func vibrate(duration:float = 500)->void:
	if not vibrate_on: return
	Input.vibrate_handheld(duration)
