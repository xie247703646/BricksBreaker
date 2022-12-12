extends UIBase
class_name UIGame

onready var btn_sound: TextureButton = $BtnSound
onready var btn_pause: TextureButton = $BtnPause

func on_open(data):
	btn_sound.pressed = AudioMgr.is_sound_muted()
	btn_sound.connect("toggled",self,"_on_btn_sound_toggled")

func on_close(data):
	btn_sound.disconnect("toggled",self,"_on_btn_sound_toggled")

func _on_btn_sound_toggled(btn_pressed:bool)->void:
	AudioMgr.set_sound_mute(btn_pressed)


func _on_BtnPause_pressed() -> void:
	UIMgr.open_ui(UI.UIPause)
