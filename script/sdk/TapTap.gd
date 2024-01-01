extends Node

signal login_success
signal login_fail

const TapTap:String = "TapTap"

const Client_Id:String = "s53etn2vcknc3wpzae"
const Client_Token:String = "2QAITRC5F35g9YyxJSbgOOzdajuYi0t3MmhC5h6I"
const Server_Url:String = "https://s53etn2v.cloud.tds1.tapapis.cn"

var taptap

func init() -> void:
	if Engine.has_singleton(TapTap):
		taptap = Engine.get_singleton(TapTap)
		taptap.init(Client_Id,Client_Token,Server_Url)
		init_signal()
		Debug.Log(TapTap,"初始化成功")
	else:
		Debug.Error(TapTap,"初始化失败")

func init_signal()->void:
	taptap.connect("login_success",self,"_on_login_success")
	taptap.connect("login_fail",self,"_on_login_fail")

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
