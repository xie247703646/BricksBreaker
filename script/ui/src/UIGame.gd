extends UIBase
class_name UIGame

onready var btn_sound: TextureButton = $BtnSound
onready var btn_vibrate: TextureButton = $BtnVibrate
onready var btn_pause: TextureButton = $BtnPause
var is_testing:bool = false

func on_open(data):
	if data: is_testing = true
	btn_sound.pressed = AudioMgr.is_sound_muted()
	btn_vibrate.pressed = not DeviceMgr.vibrate_on
	btn_sound.connect("toggled",self,"_on_btn_sound_toggled")

func on_close(data):
	btn_sound.disconnect("toggled",self,"_on_btn_sound_toggled")

func _on_btn_sound_toggled(btn_pressed:bool)->void:
	AudioMgr.set_sound_mute(btn_pressed)

func _on_BtnVibrate_toggled(button_pressed: bool) -> void:
	DeviceMgr.vibrate_on = not button_pressed

func _on_BtnPause_pressed() -> void:
	UIMgr.open_ui(UI.UIPause,is_testing)


