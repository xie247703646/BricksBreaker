extends Node

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

var _inited:bool = false

func _ready() -> void:
	sfx_enabled = SaveMgr.get_value(Global.Section_Misc,"sfx_enabled",true)
	vibrate_enabled = SaveMgr.get_value(Global.Section_Misc,"vibrate_enabled",true)
	ad_enabled = SaveMgr.get_value(Global.Section_Misc,"ad_enabled",true)
	_inited = true
	SaveMgr.save()