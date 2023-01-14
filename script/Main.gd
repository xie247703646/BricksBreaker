extends Node

func _ready() -> void:
	randomize()
	_game_init()
	_game_ready()

func _game_init()->void:
	UIMgr.init($UIRoot,$"%InputBlock",$"%WindowMask")
	GameMgr.init($GameRoot)

func _game_ready()->void:
	if ConfigMgr.has_section_key("Policy","policy_agreed"):
		UIMgr.open_ui(UI.UIAdvice)
	else:
		UIMgr.open_ui(UI.UIPolicy)
