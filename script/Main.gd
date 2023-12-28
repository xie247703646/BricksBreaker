extends Node

export var is_debug:bool = false

func _ready() -> void:
	match Global.Cur_Platform:
		Global.Platform.CrazyGame:
			TranslationServer.set_locale("en")
		Global.Platform.TapTap:
			TranslationServer.set_locale("zh")
	
	randomize()
	GameMgr.is_debug = is_debug
	_game_init()
	_game_ready()

func _game_init()->void:
	UIMgr.init($UIRoot,$"%InputBlock",$"%WindowMask")
	GameMgr.init($GameRoot)
	AdMgr.init()

func _game_ready()->void:
	var ui = UI.UIAdvice if DeviceUtil.is_mobile() else UI.UIMain
	UIMgr.open_ui(ui)
