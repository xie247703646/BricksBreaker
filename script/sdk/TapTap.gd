extends Node

const TapTap:String = "TapTap"

const Client_Id:String = "s53etn2vcknc3wpzae"
const Client_Token:String = "2QAITRC5F35g9YyxJSbgOOzdajuYi0t3MmhC5h6I"
const Server_Url:String = "https://s53etn2v.cloud.tds1.tapapis.cn"

var taptap

func init() -> void:
	if Engine.has_singleton(TapTap):
		taptap = Engine.get_singleton(TapTap)
		taptap.init(Client_Id,Client_Token,Server_Url)
		Debug.Log(TapTap,"初始化成功")
	else:
		Debug.Error(TapTap,"初始化成功")

func login():
	if not taptap: return
	taptap.login()
	Debug.Log(TapTap,"登录成功")
