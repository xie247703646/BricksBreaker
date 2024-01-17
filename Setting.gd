extends Node

const version:String = "2.7"

var is_new:bool = true

var sfx_enabled:bool = true setget _set_sfx_enabled
func _set_sfx_enabled(v:bool)->void:
	sfx_enabled = v
	AudioMgr.set_sound_mute(not v)
	if _inited: SaveMgr.set_value(Global.Section_Misc,"sfx_enabled",v)

var vibrate_enabled:bool = true setget _set_vibrate_enabled
func _set_vibrate_enabled(v:bool)->void:
	vibrate_enabled = v
	if _inited: SaveMgr.set_value(Global.Section_Misc,"vibrate_enabled",v)

var ad_enabled:bool = true setget _set_ad_enabled
func _set_ad_enabled(v:bool)->void:
	ad_enabled = v
	if _inited: SaveMgr.set_value(Global.Section_Misc,"ad_enabled",v)

var control_mode:int = Global.ControlMode.Slide setget _set_control_mode
func _set_control_mode(v:int)->void:
	control_mode = v
	if _inited: SaveMgr.set_value(Global.Section_Misc,"control_mode",v)

var _inited:bool = false

func _ready() -> void:
	sfx_enabled = SaveMgr.get_value(Global.Section_Misc,"sfx_enabled",true)
	vibrate_enabled = SaveMgr.get_value(Global.Section_Misc,"vibrate_enabled",true)
	ad_enabled = SaveMgr.get_value(Global.Section_Misc,"ad_enabled",true)
	control_mode = SaveMgr.get_value(Global.Section_Misc,"control_mode",Global.ControlMode.Slide)
	_inited = true
	SaveMgr.save()
