extends UIBase

onready var btn_sfx: Button = $VBoxContainer/BtnSfx
onready var btn_vibrate: Button = $VBoxContainer/BtnVibrate
onready var btn_control: Button = $VBoxContainer/BtnControl

func _ready() -> void:
	update_control_mode()

func on_open(data):
	pass

func on_close(data):
	pass

func _on_BtnClose_pressed() -> void:
	close()
	var ui_main = UIMgr.get_ui(UI.UIMain)
	ui_main.call("on_show")

func _on_BtnSfx_pressed() -> void:
	Setting.sfx_enabled = not Setting.sfx_enabled
	update_sfx()

func _on_BtnVibrate_pressed() -> void:
	Setting.vibrate_enabled = not Setting.vibrate_enabled
	update_vibrate()

func _on_BtnControl_pressed() -> void:
	Setting.control_mode = (Setting.control_mode + 1) % 3
	update_control_mode()

func update_control_mode()->void:
	match Setting.control_mode:
		Global.ControlMode.Follow: btn_control.text = "操作方式：跟随"
		Global.ControlMode.Slide: btn_control.text = "操作方式：滑动"
		Global.ControlMode.Click: btn_control.text = "操作方式：点击"

func update_sfx()->void:
	btn_sfx.text = "声音：开" if Setting.sfx_enabled else "声音：关"

func update_vibrate()->void:
	btn_vibrate.text = "震动：开" if Setting.vibrate_enabled else "震动：关"

func _on_BtnTip_pressed() -> void:
	match Setting.control_mode:
		Global.ControlMode.Follow: UIMgr.show_toast(UI.UIToast,"反弹板跟随手指移动")
		Global.ControlMode.Slide: UIMgr.show_toast(UI.UIToast,"手指左右滑动以控制反弹板")
		Global.ControlMode.Click: UIMgr.show_toast(UI.UIToast,"点击左右屏幕以控制反弹板")
