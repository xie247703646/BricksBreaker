extends UIBase
class_name UIAdvice

func on_open(data):
	pass

func on_close(data):
	pass

func _on_Timer_timeout() -> void:
	UIMgr.open_ui(UI.UIMain)
	close()
