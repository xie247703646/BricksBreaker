extends UIBase

func on_open(data):
	get_tree().paused = true

func on_close(data):
	get_tree().paused = false

func _on_BtnResume_pressed() -> void:
	close()

func _on_BtnRestart_pressed() -> void:
	close()
	if GameMgr.is_testing:
		GameMgr.game_quit()
		GameMgr.test_level(GameMgr.level_ins)
	elif GameMgr.is_co_create_level:
		GameMgr.game_quit()
		GameMgr.load_co_create_level(GameMgr.level_ins)
	else:
		GameMgr.game_restart()

func _on_BtnClose_pressed() -> void:
	GameMgr.game_quit()
	close()
	UIMgr.close_ui(UI.UIGame)
	
	if GameMgr.is_testing:
		UIMgr.open_ui(UI.UILevelEditor)
	elif GameMgr.is_co_create_level:
		UIMgr.open_ui(UI.UICoCreate)
	else:
		UIMgr.open_ui(UI.UIMain)
