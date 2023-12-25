tool
extends TileMap

const Json_File_Path:String = "res://asset/aseprite_level/%s.json"

export var maker:String = "官方"
export var load_data:bool = false setget _set_load_data
func _set_load_data(v:bool)->void:
	if not Engine.editor_hint: return
	if v: _load_json_file()
	load_data = false

func _ready() -> void:
	pass

func _load_json_file()->void:
	var path:String = Json_File_Path % name
	var file:File = File.new()
	if not file.file_exists(path): 
		Debug.Warn(name,"file not exist")
		return
	file.open(path,File.READ)
	var content = file.get_as_text()
	var level_data:Dictionary = parse_json(content)
	clear()
	for key in level_data:
		var p:Array = key.split("-")
		var x:int = int(p[0])
		var y:int = int(p[1])
		var type:int = level_data[key]
		set_cell(x,y,type)
