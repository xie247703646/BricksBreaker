extends Reference
class_name LevelMaker

const Maker_Info:Array = [
	{
		"name":"熙望熙望",
		"level":[71,72,73,74,75]
	},
	{
		"name":"糖加一勺",
		"level":[76,77,78,79,80]
	}
]

static func get_name(level_id:int)->String:
	for maker_info in Maker_Info:
		var name:String = maker_info["name"]
		var level:Array = maker_info["level"]
		if level_id in level: return name
	return "官方"
