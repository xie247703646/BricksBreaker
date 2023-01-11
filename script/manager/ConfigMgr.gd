extends Node

const SAVE_PATH = "user://config_data.cfg"
var cfg_file:ConfigFile = null

func _ready() -> void:
	cfg_file = ConfigFile.new()

func save()->void:
	cfg_file.save(SAVE_PATH)

func set_value(section:String,key:String,value,save:bool = true)->void:
	cfg_file.set_value(section,key,value)
	if save: save()

func set_value_with_dic(section:String,dic:Dictionary,save:bool = true)->void:
	for key in dic:
		var value = dic[key]
		cfg_file.set_value(section,key,value)
	if save: save()

func get_value(section:String,key:String,default_value = null):
	var info = cfg_file.load(SAVE_PATH)
	if info != OK:
		printerr("配置文件路径错误 %s,将使用默认值 %s" % [SAVE_PATH,default_value])
		return default_value
	if not cfg_file.has_section(section):
		printerr("配置中不存在section %s,将使用默认值 %s" % [section,default_value])
		return default_value
	if not cfg_file.has_section_key(section,key):
		printerr("section %s 中不存在key %s,将使用默认值 %s" % [section,key,default_value])
		return default_value
	var value = cfg_file.get_value(section,key)
	return value

func has_section(section:String)->bool:
	return cfg_file.has_section(section)

func has_section_key(section:String,key:String)->bool:
	if not has_section(section): return false
	return cfg_file.has_section_key(section,key)
