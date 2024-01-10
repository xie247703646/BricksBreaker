extends UIBase

onready var lb_time: Label = $Ct/LbTime
onready var btn_roast: Button = $GameMode/BtnRoast
onready var btn_restart: Button = $GameMode/BtnRestart

func on_open(data):
	btn_restart.visible = GameMgr.mode == GameMgr.Mode.Normal
	
	match Global.Cur_Platform:
		Global.Platform.CrazyGame:
			btn_roast.visible = false
		Global.Platform.TapTap:
			btn_roast.visible = true
	
	get_tree().paused = true
	var time:int = Time.get_ticks_msec() - GameMgr.start_time
	lb_time.text = tr("key_time") % TimeUtil.format(time)

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

func _on_BtnRestart_pressed() -> void:
	EventTracker.track("#level_try_again")
	GameMgr.game_quit()
	GameMgr.start_normal_level(GameMgr.cur_level)
	close()
