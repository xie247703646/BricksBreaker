extends UIBase

onready var level_container: Control = $LevelContainer
onready var level_map: TileMap = $LevelContainer/LevelMap
onready var misc: Control = $Misc
onready var lb_tip: Label = $Misc/LbTip

var select_level:int = 0 setget _set_select_level
func _set_select_level(v:int)->void:
	select_level = v
	SaveMgr.set_value(Global.Section_Co_Create_Level,"select_co_create_level",v)

var mgr = LevelEditorMgr
var co_create_level:Array = []

func on_open(data):
	select_level = SaveMgr.get_value(Global.Section_Co_Create_Level,"select_co_create_level",0)
	co_create_level = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
	if select_level >= co_create_level.size(): set("select_level",0)
	var has_co_create_level:bool = not co_create_level.empty()
	lb_tip.visible = not has_co_create_level
	if has_co_create_level:
		load_map_data(co_create_level[select_level])

	SignalMgr.connect("ui_opened",self,"_on_ui_opened")
	SignalMgr.connect("ui_closed",self,"_on_ui_closed")

func on_close(data):
	SignalMgr.disconnect("ui_opened",self,"_on_ui_opened")
	SignalMgr.disconnect("ui_closed",self,"_on_ui_closed")

func load_map_data(level_map_str:String)->void:
	var level_map_data = mgr.decode_map_data(level_map_str)
	level_map.clear()
	for x in range(0,mgr.MAX_COL):
		for y in range(0,mgr.MAX_ROW):
			var idx = level_map_data[x][y]
			if idx != -1: level_map.set_cell(x,y,idx)

func _on_BtnStart_pressed() -> void:
	if co_create_level.empty():
		UIMgr.show_toast(UI.UIToast,"当前没有玩创关卡")
	else:
		close()
		GameMgr.load_co_create_level(level_map)
	
func _on_BtnImport_pressed() -> void:
	UIMgr.open_ui(UI.UIImportLevel)

func _on_BtnClose_pressed() -> void:
	close()
	UIMgr.open_ui(UI.UIMain)

func _on_BtnEditor_pressed() -> void:
	close()
	UIMgr.open_ui(UI.UILevelEditor)

func _on_ui_opened(ui_name:String)->void:
	match ui_name:
		UI.UILevelCode: misc.visible = false
		UI.UIImportLevel: misc.visible = false
		UI.UIConfirm: misc.visible = false

func _on_ui_closed(ui_name:String)->void:
	match ui_name:
		UI.UIConfirm: 
			misc.visible = true
			co_create_level = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
			var has_co_create_level:bool = not co_create_level.empty()
			lb_tip.visible = not has_co_create_level
			if has_co_create_level:
				set("select_level",0)
				load_map_data(co_create_level[select_level])
			else:
				level_map.clear()
				
		UI.UILevelCode: misc.visible = true
		
		UI.UIImportLevel: 
			misc.visible = true
			co_create_level = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
			if not co_create_level.empty():
				set("select_level",co_create_level.find(LevelEditorMgr.last_import_map_str))
				load_map_data(co_create_level[select_level])

func _on_BtnCode_pressed() -> void:
	if co_create_level.empty():
		UIMgr.show_toast(UI.UIToast,"当前没有玩创关卡")
	else:
		UIMgr.open_ui(UI.UILevelCode,co_create_level[select_level])

func _on_BtnDelete_pressed() -> void:
	if co_create_level.empty():
		UIMgr.show_toast(UI.UIToast,"当前没有玩创关卡")
	else:
		UIMgr.open_ui(UI.UIConfirm,{"tip":"确定要删除该关卡？","func_yes":funcref(self,"_delete_level")})

func _delete_level()->void:
	co_create_level.remove(select_level)
	SaveMgr.set_value(Global.Section_Co_Create_Level,"co_create_level",co_create_level)
	UIMgr.show_toast(UI.UIToast,"删除成功")

func _on_BtnLeft_pressed() -> void:
	if co_create_level.empty(): return
	select_level += 1
	if select_level >= co_create_level.size(): select_level = 0
	set("select_level",select_level)
	load_map_data(co_create_level[select_level])

func _on_BtnRight_pressed() -> void:
	if co_create_level.empty(): return
	select_level -= 1
	if select_level < 0: 
		select_level = co_create_level.size() - 1
	set("select_level",select_level)
	load_map_data(co_create_level[select_level])
