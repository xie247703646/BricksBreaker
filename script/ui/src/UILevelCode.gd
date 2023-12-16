extends UIBase

onready var text_edit: TextEdit = $TextEdit

func on_open(data):
	text_edit.text = data

func on_close(data):
	pass

func _on_BtnClose_pressed() -> void:
	close()

func _on_BtnCopy_pressed() -> void:
	close()
	OS.clipboard = ""
	OS.clipboard = text_edit.text
	if OS.clipboard:
		UIMgr.show_toast(UI.UIToast,"复制成功，分享给其他玩家吧！")
	else:
		UIMgr.show_toast(UI.UIToast,"复制失败，请尝试手动复制!")
