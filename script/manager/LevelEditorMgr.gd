extends Node

const CELL_SIZE:int = 16
const MAX_ROW:int = 60
const MAX_COL:int = 45
const GRID_COLOR:Color = Color(1,1,1,0.18)
var level_map_data:Array = []
var last_import_map_str:String
#穷 暴富一夜
func save_co_create_level(map_str:String)->void:
	last_import_map_str = map_str
	var co_create_level:Array = SaveMgr.get_value(Global.Section_Co_Create_Level,"co_create_level",[])
	if not co_create_level.has(map_str):
		co_create_level.append(map_str)
		SaveMgr.set_value(Global.Section_Co_Create_Level,"co_create_level",co_create_level)

func encode_map_data(map_data:Array)->String:
	var map_str:String = ""
	
	for x in map_data.size():
		var s:String = ""
		for y in map_data[x].size():
			var brick_type:int = map_data[x][y]
			var symbol:String = char(brick_type + 1 + 65)
			s += symbol
		s = MathUtil.encode(s)
		s += "O"
		map_str += s
		
	map_str.erase(len(map_str) - 1,1)

	return map_str
	
func decode_map_data(map_str:String)->Array:
	var row_str_arr:PoolStringArray = map_str.split("O")
	var map_data:Array = []
	for row_str in row_str_arr:
		var decode_str:String = MathUtil.decode(row_str)
		var arr:Array = []
		for symbol in decode_str:
			var brick_type:int = ord(symbol) - 1 - 65
			arr.append(brick_type)
		map_data.append(arr)
	return map_data

func is_map_empty(map_data:Array)->bool:
	for x in map_data.size():
		for y in map_data[x].size():
			var brick_type:int = map_data[x][y]
			if brick_type != -1: return false
	return true

func is_level_map_data_valid(level_map_data:Array)->bool:
	return level_map_data.size() == MAX_ROW
