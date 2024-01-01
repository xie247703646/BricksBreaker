extends UIBase

func on_open(data):
	TapTap.connect("login_success",self,"_on_login_success")
	TapTap.connect("login_fail",self,"_on_login_fail")

func on_close(data):
	TapTap.disconnect("login_success",self,"_on_login_success")
	TapTap.disconnect("login_fail",self,"_on_login_fail")

func _on_BtnLogin_pressed() -> void:
	TapTap.login()

func _on_login_success()->void:
	TapTap.init_achieve()
	close()
	UIMgr.open_ui(UI.UIMain)
	UIMgr.show_toast(UI.UIToast,"登录成功")

func _on_login_fail()->void:
	UIMgr.show_toast(UI.UIToast,"登录失败")
