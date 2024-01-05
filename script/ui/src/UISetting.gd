extends UIBase

onready var btn_sfx: Button = $VBoxContainer/BtnSfx
onready var btn_vibrate: Button = $VBoxContainer/BtnVibrate
onready var btn_control: Button = $VBoxContainer/BtnControl

func _ready() -> void:
	update_sfx()
	update_vibrate()
	update_control_mode()

func on_open(data):
	match Global.Cur_Platform:
		Global.Platform.CrazyGame:
			btn_vibrate.visible = false
			btn_control.visible = false
		Global.Platform.TapTap:
			btn_vibrate.visible = true
			btn_control.visible = true

func on_close(data):
	pass

func _on_BtnClose_pressed() -> void:
	close()
	var ui_main = UIMgr.get_ui(UI.UIMain)
	if ui_main: ui_main.call("on_show")

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
	var str_sfx_on:String = tr("key_sfx_switch") + tr("key_on")
	var str_sfx_off:String = tr("key_sfx_switch") + tr("key_off")
	btn_sfx.text = str_sfx_on if Setting.sfx_enabled else str_sfx_off

func update_vibrate()->void:
	var str_vibrate_on:String = tr("key_vibrate_switch") + tr("key_on")
	var str_vibrate_off:String = tr("key_vibrate_switch") + tr("key_off")
	btn_vibrate.text = str_vibrate_on if Setting.vibrate_enabled else str_vibrate_off

func _on_BtnTip_pressed() -> void:
	match Setting.control_mode:
		Global.ControlMode.Follow: UIMgr.show_toast(UI.UIToast,"反弹板跟随手指移动")
		Global.ControlMode.Slide: UIMgr.show_toast(UI.UIToast,"手指左右滑动以控制反弹板")
		Global.ControlMode.Click: UIMgr.show_toast(UI.UIToast,"点击左右屏幕以控制反弹板")
