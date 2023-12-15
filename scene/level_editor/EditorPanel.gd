extends PanelContainer

var line_arr:PoolVector2Array = []
var show_grid:bool = true

func _ready() -> void:
	_init_grid()

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
