extends Node

export var is_debug:bool = false

onready var http_request: HTTPRequest = $HTTPRequest

func _ready() -> void:
	randomize()
	
	match Global.Cur_Platform:
		Global.Platform.CrazyGame:
			TranslationServer.set_locale("en")
		Global.Platform.TapTap:
			TranslationServer.set_locale("zh")
	
	GameMgr.is_debug = is_debug
	_game_init()
	_game_ready()
	
#	http_request.request("https://img3.tapimg.com/avatars/6cea6bf657a483de39cd824f5233902f.webp")

func _game_init()->void:
#	CloudDataMgr.init()
	UIMgr.init($UIRoot,$"%InputBlock",$"%WindowMask")
	GameMgr.init($GameRoot)
	AchieveMgr.init()
	AdMgr.init()
	TapTap.init()

func _game_ready()->void:
	EventTracker.track("#game_launch")
	if DeviceUtil.is_mobile():
		UIMgr.open_ui(UI.UIAdvice)
	else:
		UIMgr.open_ui(UI.UIMain)
	
	if len(GameMgr.unlocked_levels) == 1:
		SaveMgr.set_value(Global.Section_Misc,"is_new",true)

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var image = Image.new()
	
	var res = image.load_webp_from_buffer(body)
	
	if res == OK:
		var texture = ImageTexture.new()
		texture.create_from_image(image)
			# 将图片显示到 TextureRect 节点上。
		var texture_rect = TextureRect.new()
		add_child(texture_rect)
		texture_rect.texture = texture
	else:
		print("无法加载图片",res)

