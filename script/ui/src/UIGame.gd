extends UIBase
class_name UIGame

onready var btn_sound: TextureButton = $BtnSound
onready var btn_vibrate: TextureButton = $BtnVibrate
onready var btn_ad: TextureButton = $BtnAd
onready var btn_pause: TextureButton = $BtnPause

func on_open(data):
	btn_sound.pressed = not Setting.sfx_enabled
	btn_vibrate.pressed = not Setting.vibrate_enabled
	btn_ad.pressed = not Setting.ad_enabled
	btn_sound.connect("toggled",self,"_on_btn_sound_toggled")

func on_close(data):
	btn_sound.disconnect("toggled",self,"_on_btn_sound_toggled")

func _on_btn_sound_toggled(btn_pressed:bool)->void:
	Setting.sfx_enabled = not btn_pressed
#	AudioMgr.set_sound_mute(btn_pressed)

func _on_BtnVibrate_toggled(button_pressed: bool) -> void:
	Setting.vibrate_enabled = not button_pressed
#	DeviceMgr.vibrate_on = not button_pressed

func _on_BtnPause_pressed() -> void:
	UIMgr.open_ui(UI.UIPause)

func _on_BtnAd_toggled(button_pressed: bool) -> void:
	pass
