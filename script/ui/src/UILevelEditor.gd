extends UIBase

export(ButtonGroup) var btn_group_color:ButtonGroup
export(ButtonGroup) var btn_group_tool:ButtonGroup

onready var map_container: ColorRect = $MapContainer
onready var level_map: TileMap = $MapContainer/LevelMap

onready var draw_tool: Control = $DrawTool
onready var move_tool: Control = $MoveTool
onready var erase_tool: Control = $EraseTool

var view_scale:float = 1.0
var move_start_pos:Vector2 = Vector2.ZERO
var move_speed:float = 10.0

func _init_map()->void:
	var mgr = LevelEditorMgr
#	var level_saved:Array = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
	var level_map_data = LevelEditorMgr.level_map_data
	if level_map_data.empty():
		for x in range(0,mgr.MAX_COL):
			level_map_data.append([])
			for y in range(0,mgr.MAX_ROW):
				level_map_data[x].append(-1)
	else:
		for x in range(0,mgr.MAX_COL):
			for y in range(0,mgr.MAX_ROW):
				var idx = level_map_data[x][y]
				if idx != -1: level_map.set_cell(x,y,idx)

func on_open(data):
	_init_map()

func on_close(data):
	pass

func _input(event: InputEvent) -> void:
	if not is_moving(): return
	var mouse_pos:Vector2 = get_global_mouse_position()
	if not map_container.get_rect().has_point(mouse_pos): return
	if event is InputEventMouseButton: 
		if event.is_pressed():
			move_start_pos = mouse_pos
		else:
			move_start_pos = Vector2.ZERO

	if event is InputEventMouseMotion and move_start_pos != Vector2.ZERO:
		var pos = mouse_pos
		var dir = move_start_pos.direction_to(pos)
		var dis = move_start_pos.distance_to(pos)
		level_map.position += dir * move_speed
		move_start_pos = mouse_pos
	
func _process(delta: float) -> void:
	if not Input.is_mouse_button_pressed(BUTTON_LEFT): return
	if is_drawing(): _draw_brick()
	if is_erasing(): _erase_brick()

func _draw_brick()->void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	if not map_container.get_rect().has_point(mouse_pos): return
	var map_pos:Vector2 = level_map.world_to_map((mouse_pos - level_map.global_position) / view_scale)
	if _is_out_of_bounds(map_pos): return
	var btn:Button = btn_group_color.get_pressed_button()
	if not btn: return
	var idx = btn.get_index()
	LevelEditorMgr.level_map_data[map_pos.x][map_pos.y] = idx
	level_map.set_cellv(map_pos,idx)

func _erase_brick()->void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	if not map_container.get_rect().has_point(mouse_pos): return
	var map_pos:Vector2 = level_map.world_to_map((mouse_pos - level_map.global_position) / view_scale)
	if _is_out_of_bounds(map_pos): return
	LevelEditorMgr.level_map_data[map_pos.x][map_pos.y] = -1
	level_map.set_cellv(map_pos,-1)

func _move_map()->void:
	level_map.position += Vector2.DOWN

func _is_out_of_bounds(map_pos:Vector2)->bool:
	var mgr = LevelEditorMgr
	if map_pos.x < 0 or map_pos.x >= mgr.MAX_COL: return true
	if map_pos.y < 0 or map_pos.y >= mgr.MAX_ROW: return true
	return false

func _on_CBtnGridSwitch_toggled(button_pressed: bool) -> void:
	level_map.show_grid = button_pressed

func _on_BtnTest_pressed() -> void:
	var level_map_data = LevelEditorMgr.level_map_data
	if LevelEditorMgr.is_map_empty(level_map_data):
		UIMgr.show_toast(UI.UIToast,"空关卡无法测试")
	else:
		close()
		GameMgr.test_level(level_map)

func _on_BtnSave_pressed() -> void:
	var level_map_data = LevelEditorMgr.level_map_data
	var encode_map_str:String = LevelEditorMgr.encode_map_data(level_map_data)
	var level_saved:Array = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
	if LevelEditorMgr.is_map_empty(level_map_data):
		UIMgr.show_toast(UI.UIToast,"无法保存空关卡")
	elif level_saved.has(encode_map_str):
		UIMgr.show_toast(UI.UIToast,"本地已有与其相同的关卡")
	else:
		level_saved.append(encode_map_str)
		SaveMgr.set_value(Global.Section_Co_Create_Level,"co_create_level",level_saved)
		UIMgr.show_toast(UI.UIToast,"保存成功")

func _on_BtnClose_pressed() -> void:
	close()
	UIMgr.open_ui(UI.UICoCreate)

func is_drawing()->bool:
	var btn = btn_group_tool.get_pressed_button()
	return btn and btn.name == "BtnDraw"

func is_moving()->bool:
	var btn = btn_group_tool.get_pressed_button()
	return btn and btn.name == "BtnMove"

func is_erasing()->bool:
	var btn = btn_group_tool.get_pressed_button()
	return btn and btn.name == "BtnErase"

func _on_HSlider_value_changed(value: float) -> void:
	view_scale = value / 10
	level_map.scale = Vector2.ONE * view_scale

func _on_BtnPosReset_pressed() -> void:
	level_map.position = Vector2.ZERO

func _on_BtnEraseAll_pressed() -> void:
	UIMgr.open_ui(UI.UIConfirm,{"tip":"是否要擦除所有砖块?","func_yes":funcref(self,"erase_all")})
	
func erase_all()->void:
	LevelEditorMgr.level_map_data.clear()
	level_map.clear()

func _on_change_tool()->void:
	get_tree().call_group("Tool","hide")
	yield(get_tree().create_timer(0.05),"timeout")
	if is_drawing(): draw_tool.show()
	if is_moving(): move_tool.show()
	if is_erasing(): erase_tool.show()

func _on_HsMoveSpeed_value_changed(value: float) -> void:
	move_speed = value
