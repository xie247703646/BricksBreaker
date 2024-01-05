extends Node

signal login_success
signal login_fail
signal get_rank_data_success
signal get_rank_data_fail

const TapTap:String = "TapTap"

const Client_Id:String = "s53etn2vcknc3wpzae"
const Client_Token:String = "2QAITRC5F35g9YyxJSbgOOzdajuYi0t3MmhC5h6I"
const Server_Url:String = "https://s53etn2v.cloud.tds1.tapapis.cn"

var taptap

func init() -> void:
	if is_valid():
		taptap = Engine.get_singleton(TapTap)
		taptap.init(Client_Id,Client_Token,Server_Url)
		init_signal()
		Debug.Log(TapTap,"初始化成功")
	else:
		Debug.Error(TapTap,"初始化失败")

func is_valid()->bool:
	return Engine.has_singleton(TapTap)

func init_signal()->void:
	taptap.connect("login_success",self,"_on_login_success")
	taptap.connect("login_fail",self,"_on_login_fail")
	taptap.connect("get_rank_data_success",self,"_on_get_rank_data_success")
	taptap.connect("get_rank_data_fail",self,"_on_get_rank_data_fail")

func get_object_id()->String:
	if not taptap: return ""
	return taptap.getObjectId()

func login():
	if not taptap: return
	taptap.login()

func has_user()->bool:
	if not taptap: return false
	return taptap.hasUser()

func _on_login_success()->void:
	emit_signal("login_success")

func _on_login_fail()->void:
	emit_signal("login_fail")

func init_achieve():
	if not taptap: return
	taptap.initAchieve()

func reach_achieve(achieve_id:String):
	if not taptap: return
	taptap.reachAchieve(achieve_id)

func show_achieve_page():
	if not taptap: return
	taptap.showAchievePage()

func track_event(event_name:String,data:Dictionary = {})->void:
	Debug.Log(name,"追踪事件%s -- %s" % [event_name,data])
	if not taptap: return
	taptap.trackEvent(event_name,JSON.print(data))

func get_rank_data(rank_name:String,limit:int)->void:
	if not taptap: return
	taptap.getRankData(rank_name,limit)

func submit_rank_data(rank_name:String,data:float)->void:
	if not taptap: return
	taptap.submitRankData(rank_name,data)

func _on_get_rank_data_success(json_str:String)->void:
	var rank_data:Dictionary = JSON.parse(json_str).result
	emit_signal("get_rank_data_success",rank_data)
#	for key in rank_data:
#		var rank:int = int(key)
#		var data:Dictionary = rank_data[key]
#		var nick_name:String = data["nickname"]
#		var score:int = data["score"]
#		Debug.Log(name,"第%s的昵称为%s,成绩为%s" % [rank,nick_name,score])

func _on_get_rank_data_fail()->void:
	emit_signal("get_rank_data_fail")
