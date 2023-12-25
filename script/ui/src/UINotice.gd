extends UIBase


func on_open(data):
	pass

func on_close(data):
	var ui_main = UIMgr.get_ui(UI.UIMain)
	ui_main.call("on_show")

func _on_BtnClose_pressed() -> void:
	close()
