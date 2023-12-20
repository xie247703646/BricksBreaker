extends UIBase

onready var lb_time: Label = $Ct/LbTime

func on_open(data):
	get_tree().paused = true
	var time:int = Time.get_ticks_msec() - GameMgr.start_time
	lb_time.text = "已用时 %s" % TimeUtil.format(time)

func on_close(data):
	get_tree().paused = false

func _on_BtnResume_pressed() -> void:
	close()

func _on_BtnClose_pressed() -> void:
	GameMgr.game_quit()
	close()
	UIMgr.close_ui(UI.UIGame)
	
	match GameMgr.mode:
		GameMgr.Mode.Normal: UIMgr.open_ui(UI.UIMain)
		GameMgr.Mode.Test: UIMgr.open_ui(UI.UILevelEditor)
		GameMgr.Mode.CoCreate: UIMgr.open_ui(UI.UICoCreate)

func _on_BtnRoast_pressed() -> void:
	GameMgr.open_game_page()
