extends UIBase
class_name UILevelEditor

export(ButtonGroup) var btn_group:ButtonGroup

onready var tabs: Tabs = $Tabs
onready var level_map: TileMap = $LevelMap

var line_arr:PoolVector2Array = []
var show_grid:bool = true
var is_drawing:bool = false
var is_erasing:bool = false

func _init_map()->void:
	var mgr = LevelEditorMgr
	var level_map_data = mgr.level_map_data
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
	tabs.add_tab(" Draw ")
	tabs.add_tab(" Erase ")
	_init_grid()
	_init_map()

func on_close(data):
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var is_pressed:bool = event.pressed
		var btn_idx = event.button_index
		var was_drawing = is_drawing
		var was_erasing = is_erasing
		is_drawing = is_pressed and btn_idx == BUTTON_LEFT
		is_erasing = is_pressed and btn_idx == BUTTON_RIGHT
		if was_drawing and not is_drawing: _draw_brick()
		if was_erasing and not is_erasing: _erase_brick()
	if event is InputEventMouseMotion:
		if is_drawing: _draw_brick()
		if is_erasing: _erase_brick()

func _draw_brick()->void:
	var map_pos = level_map.world_to_map(get_global_mouse_position())
	if _is_out_of_bounds(map_pos): return
	var btn:Button = btn_group.get_pressed_button()
	if not btn: return
	var idx = btn.get_index()
	LevelEditorMgr.level_map_data[map_pos.x][map_pos.y] = idx
	level_map.set_cellv(map_pos,idx)

func _erase_brick()->void:
	var map_pos = level_map.world_to_map(get_global_mouse_position())
	if _is_out_of_bounds(map_pos): return
	LevelEditorMgr.level_map_data[map_pos.x][map_pos.y] = -1
	level_map.set_cellv(map_pos,-1)

func _is_out_of_bounds(map_pos:Vector2)->bool:
	var mgr = LevelEditorMgr
	if map_pos.x < 0 or map_pos.x >= mgr.MAX_COL: return true
	if map_pos.y < 0 or map_pos.y >= mgr.MAX_ROW: return true
	return false

func _init_grid()->void:
	var mgr = LevelEditorMgr
	for i in range(1,mgr.MAX_ROW):
		var y = mgr.CELL_SIZE * i
		line_arr.append_array([Vector2(0,y),Vector2(720,y)])
	var h = mgr.MAX_ROW * mgr.CELL_SIZE
	for i in range(1,mgr.MAX_COL):
		var x = mgr.CELL_SIZE * i
		line_arr.append_array([Vector2(x,0),Vector2(x,h)])

func _draw_grid()->void:
	var mgr = LevelEditorMgr
	draw_rect(Rect2(1,1,mgr.MAX_COL * mgr.CELL_SIZE - 1,mgr.MAX_ROW * mgr.CELL_SIZE),mgr.GRID_COLOR,false,1)
	draw_multiline(line_arr,mgr.GRID_COLOR,1)

func _draw() -> void:
	if show_grid: _draw_grid()

func _on_CBtnGridSwitch_toggled(button_pressed: bool) -> void:
	show_grid = button_pressed
	update()

func _on_BtnTest_pressed() -> void:
	close()
	GameMgr.test_level(level_map)

func _on_BtnClose_pressed() -> void:
	close()
	UIMgr.open_ui(UI.UIMain)
