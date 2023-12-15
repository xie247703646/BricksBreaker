extends UIBase
class_name UIPause

onready var game_mode: VBoxContainer = $GameMode
onready var test_mode: VBoxContainer = $TestMode

func on_open(data):
	test_mode.visible = GameMgr.is_testing
	game_mode.visible = not GameMgr.is_testing
	get_tree().paused = true

func on_close(data):
	get_tree().paused = false

func _on_BtnResume_pressed() -> void:
	close()

func _on_BtnRestart_pressed() -> void:
	close()
	GameMgr.game_restart()

func _on_BtnMainMenu_pressed() -> void:
	GameMgr.game_quit()
	close()
	UIMgr.close_ui(UI.UIGame)
	UIMgr.open_ui(UI.UIMain)

func _on_BtnLevelEditor_pressed() -> void:
	GameMgr.game_quit()
	close()
	UIMgr.close_ui(UI.UIGame)
	UIMgr.open_ui(UI.UILevelEditor)
