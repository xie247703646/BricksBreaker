extends Node

const CELL_SIZE:int = 16
const MAX_ROW:int = 60
const MAX_COL:int = 45
const GRID_COLOR:Color = Color(1,1,1,0.18)
var level_map_data:Array = []

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
		var decode_str = MathUtil.decode(row_str)
		var arr:Array = []
		for symbol in decode_str:
			var brick_type:int = ord(symbol) - 1 - 65
			arr.append(brick_type)
		map_data.append(arr)
	return map_data
