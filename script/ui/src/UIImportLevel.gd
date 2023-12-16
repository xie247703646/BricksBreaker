extends UIBase

onready var text_edit: TextEdit = $TextEdit

func on_open(data):
	if OS.clipboard:
		var temp_str:String = OS.clipboard.dedent().replacen("\n","")
		var map_str:String
		for s in temp_str:
			var asc = ord(s)
			if asc >= 48 and asc <= 57: map_str += s
			elif asc >= 65 and asc <= 90: map_str += s
			else: break
		text_edit.text = map_str
		UIMgr.show_toast(UI.UIToast,"检测到剪切板内容")

func on_close(data):
	pass

func _on_BtnClose_pressed() -> void:
	close()

func _on_BtnImport_pressed() -> void:
	var map_str:String = text_edit.text.dedent().replacen("\n","")
	if not map_str: 
		UIMgr.show_toast(UI.UIToast,"导入失败")
		return
	var level_map_data:Array = LevelEditorMgr.decode_map_data(map_str)
	if LevelEditorMgr.encode_map_data(level_map_data) == map_str:
		LevelEditorMgr.save_co_create_level(map_str)
		UIMgr.show_toast(UI.UIToast,"导入成功")
		close()
	else:
		UIMgr.show_toast(UI.UIToast,"导入失败")
	
