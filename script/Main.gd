extends Node

export var is_debug:bool = false

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

func _game_init()->void:
#	CloudDataMgr.init()
	UIMgr.init($UIRoot,$"%InputBlock",$"%WindowMask")
	GameMgr.init($GameRoot)
	AchieveMgr.init()
	AdMgr.init()
	TapTap.init()

func _game_ready()->void:
	if DeviceUtil.is_mobile():
		UIMgr.open_ui(UI.UIAdvice)
	else:
		UIMgr.open_ui(UI.UIMain)
	
	if len(GameMgr.unlocked_levels) == 1:
		SaveMgr.set_value(Global.Section_Misc,"is_new",true)
