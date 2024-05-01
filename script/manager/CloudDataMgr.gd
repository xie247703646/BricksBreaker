extends HTTPRequest

const Cloud_Data_Url:String = "https://rickxie666.gitee.io/game-config/BricksBreaker/cloud_data.json"

var data:Dictionary = {}
var request_finished:bool = false

func _ready() -> void:
	connect("request_completed", self, "_on_request_completed")

func init()->void:
	data = {
	"old_inter_show_rate":0.65,
	"new_inter_show_rate":0.6,
	"inter_show_level_threshold":5,
	"inter_show_gape":true,
	"item_weight_arr":[35,35,20,10]
}
#	request(Cloud_Data_Url)

func get_value(key:String,default = null):
	return data.get(key,default)

func has(key:String)->bool:
	return data.has(key)

func is_valid()->bool:
	return request_finished and not data.empty()

func _on_request_completed(result, response_code, headers, body):
	request_finished = true
	if result != OK: 
		Debug.Error(name,"cloud data download failed,code %s" % result)
		return
	data = parse_json(body.get_string_from_utf8())
	Debug.Log(name,"cloud data download completed")
	Debug.Log(name,JSON.print(data))
	
