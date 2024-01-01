extends UIBase

func on_open(data):
	pass

func on_close(data):
	pass

func _on_Timer_timeout() -> void:
	if TapTap.has_user():
		TapTap.init_achieve()
		UIMgr.open_ui(UI.UIMain)
	else:
		UIMgr.open_ui(UI.UILogin)
	close()
