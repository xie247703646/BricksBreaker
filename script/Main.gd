extends Node

func _ready() -> void:
	randomize()
	_game_init()
	_game_ready()

func _game_init()->void:
	UIMgr.init($UIRoot,$"%InputBlock",$"%WindowMask")
	GameMgr.init($GameRoot)

func _game_ready()->void:
	UIMgr.open_ui(UI.UIAdvice)
#	if ConfigMgr.has_section_key("Policy","policy_agreed"):
#	else:
#		UIMgr.open_ui(UI.UIPolicy)
