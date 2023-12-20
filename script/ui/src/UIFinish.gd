extends UIBase

onready var ct_win: Control = $CtWin
onready var ct_fail: Control = $CtFail
onready var lb_time: Label = $CtWin/LbTime

onready var btn_restart: Button = $Content/BtnRestart
onready var btn_next: Button = $Content/BtnNext

var win:bool = false

func on_open(data):
	win = data
	btn_restart.visible = not win and GameMgr.mode == GameMgr.Mode.Normal
	btn_next.visible = win and GameMgr.mode == GameMgr.Mode.Normal
	ct_win.visible = win
	ct_fail.visible = not win
	if win:
		var time:int = Time.get_ticks_msec() - GameMgr.start_time
		var record_dic:Dictionary = SaveMgr.get_value(GameMgr.CONFIG_SECTION,"record",{})
		var record_time:int = record_dic.get(GameMgr.cur_level,-1)
		if record_time == -1 or time < record_time:
			record_dic[GameMgr.cur_level] = time
			SaveMgr.set_value(GameMgr.CONFIG_SECTION,"record",record_dic)
			UIMgr.show_toast(UI.UIToast,"新的记录！")
		lb_time.text = "用时 %s" % TimeUtil.format(time)

func on_close(data):
	pass

func _on_BtnRoast_pressed() -> void:
	GameMgr.open_game_page()
	

func _on_BtnClose_pressed() -> void:
	UIMgr.close_ui(UI.UIGame)
	GameMgr.game_quit()
	close()
	
	match GameMgr.mode:
		GameMgr.Mode.Test: UIMgr.open_ui(UI.UILevelEditor)
		GameMgr.Mode.CoCreate: UIMgr.open_ui(UI.UICoCreate)
		GameMgr.Mode.Normal:
			var level = GameMgr.cur_level + 1 if win else GameMgr.cur_level
			level = GameMgr.clamp_level(level)
			UIMgr.open_ui(UI.UIMain,level)
			SaveMgr.set_value(GameMgr.CONFIG_SECTION,"select_level",level)

func _on_BtnRestart_pressed() -> void:
	GameMgr.game_quit()
	GameMgr.start_normal_level(GameMgr.cur_level)
	close()

func _on_BtnNext_pressed() -> void:
	close()
	var level = GameMgr.clamp_level(GameMgr.cur_level + 1)
	SaveMgr.set_value(GameMgr.CONFIG_SECTION,"select_level",level)
	GameMgr.game_quit()
	GameMgr.start_normal_level(level)
	
