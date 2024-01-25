extends UIBase

onready var btn_sound: TextureButton = $HBoxContainer/BtnSound
onready var btn_bgm: TextureButton = $HBoxContainer/BtnBgm
onready var btn_vibrate: TextureButton = $HBoxContainer/BtnVibrate
onready var btn_ad: TextureButton = $HBoxContainer/BtnAd
onready var btn_pause: TextureButton = $BtnPause

func on_open(data):
	
	AdMgr.show_banner()
	AudioMgr.play_music("bgm")
	
	match Global.Cur_Platform:
		Global.Platform.CrazyGame:
			btn_vibrate.visible = false
			btn_ad.visible = false
		Global.Platform.TapTap:
			btn_vibrate.visible = true
			btn_ad.visible = true
	
	btn_ad.visible = not Setting.is_new
	
	btn_sound.pressed = not Setting.sfx_enabled
	btn_bgm.pressed = not Setting.music_enabled
	btn_vibrate.pressed = not Setting.vibrate_enabled
	btn_ad.pressed = not Setting.ad_enabled
	btn_sound.connect("toggled",self,"_on_btn_sound_toggled")

func on_close(data):
	AdMgr.hide_banner()
	btn_sound.disconnect("toggled",self,"_on_btn_sound_toggled")

func _on_btn_sound_toggled(btn_pressed:bool)->void:
	Setting.sfx_enabled = not btn_pressed

func _on_BtnBgm_toggled(button_pressed: bool) -> void:
	Setting.music_enabled = not button_pressed

func _on_BtnVibrate_toggled(button_pressed: bool) -> void:
	Setting.vibrate_enabled = not button_pressed

func _on_BtnPause_pressed() -> void:
	UIMgr.open_ui(UI.UIPause)

func _on_BtnAd_toggled(button_pressed: bool) -> void:
	var limit:int = 50
	if GameMgr.unlocked_levels.size() >= limit:
		Setting.ad_enabled = not button_pressed
		if button_pressed:
			EventTracker.track("#disable_banner")
			AdMgr.hide_banner()
		else:
			EventTracker.track("#enable_banner")
			AdMgr.show_banner()
	else:
		Setting.ad_enabled = true
		btn_ad.pressed = false
		UIMgr.show_toast(UI.UIToast,"通过%s个关卡后解锁" % limit)
