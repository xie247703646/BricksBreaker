extends Node

const SAVE_PATH = "user://save_data.cfg"
var cfg_file:ConfigFile = ConfigFile.new()

var temp_dic:Dictionary = {}

func _ready() -> void:
	load_data()

func load_data()->void:
	Debug.Log(name,"data loaded")
	cfg_file.load(SAVE_PATH)

func save()->void:
	var res = cfg_file.save(SAVE_PATH)
	Debug.Log(name,"data saved code:%s" % res)

func save_temp()->void:
	for section in temp_dic:
		var section_dic:Dictionary = temp_dic[section]
		for key in temp_dic[section]:
			var value = section_dic[key]
			set_value(section,key,value)
	save()
	temp_dic.clear()

func set_value(section:String,key:String,value,save:bool = true)->void:
	cfg_file.set_value(section,key,value)
	if save: save()

func set_temp_value(section:String,key:String,value,save:bool = false)->void:
	if not temp_dic.has(section): temp_dic[section] = {}
	var section_dic:Dictionary = temp_dic[section]
	if not section_dic.has(key): section_dic[key] = {}
	section_dic[key] = value
	if save:save_temp()

func clear_temp()->void:
	temp_dic.clear()

func get_value(section:String,key:String,default_value = null):
	var info = cfg_file.load(SAVE_PATH)
	if info != OK:
		Debug.Error(name,"配置文件路径错误 %s,将使用默认值 %s" % [SAVE_PATH,default_value])
		return default_value
	if not cfg_file.has_section(section):
		Debug.Error(name,"配置中不存在section %s,将使用默认值 %s" % [section,default_value])
		return default_value
	if not cfg_file.has_section_key(section,key):
		Debug.Error(name,"section %s 中不存在key %s,将使用默认值 %s" % [section,key,default_value])
		return default_value
	var value = cfg_file.get_value(section,key)
	return value

func get_temp_value(section:String,key:String,default_value = null):
	if not temp_dic.has(section):
		Debug.Error(name,"temp section:%s is not exist,use default value:%s" % [section,default_value])
		return default_value
	var key_dic:Dictionary = temp_dic[section]
	if not key_dic.has(key):
		Debug.Error(name,"temp key:%s is not exist,use default value:%s" % [key,default_value])
		return default_value
	return key_dic[key]

func erase_section(section:String)->void:
	if not has_section(section): return
	cfg_file.erase_section(section)
	save()

func erase_section_key(section:String,key:String)->void:
	if not has_section_key(section,key): return
	cfg_file.erase_section_key(section,key)
	save()

func has_section(section:String)->bool:
	return cfg_file.has_section(section)

func has_section_key(section:String,key:String)->bool:
	if not has_section(section): return false
	return cfg_file.has_section_key(section,key)
