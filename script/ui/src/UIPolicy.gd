extends UIBase
class_name UIPolicy

func on_open(data):
	pass

func on_close(data):
	pass

func _on_RichTextLabel_meta_clicked(meta) -> void:
	OS.shell_open(meta)

func _on_BtnAgree_pressed() -> void:
	UIMgr.open_ui(UI.UIAdvice)
	close()
	SaveMgr.set_value("Policy","policy_agreed",true)

func _on_BtnDisagree_pressed() -> void:
	get_tree().quit()
