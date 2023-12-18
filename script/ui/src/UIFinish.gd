extends UIBase

onready var ct_win: Control = $CtWin
onready var ct_fail: Control = $CtFail
onready var lb_time: Label = $CtWin/LbTime

var win:bool = false

func on_open(data):
	win = data
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
	OS.shell_open("https://www.taptap.cn/app/270685/review")

func _on_BtnClose_pressed() -> void:
	GameMgr.game_quit()
	close()
	
	if GameMgr.is_testing:
		UIMgr.open_ui(UI.UILevelEditor)
	elif GameMgr.is_co_create_level:
		UIMgr.open_ui(UI.UICoCreate)
	else:
		var level = GameMgr.cur_level + 1 if win else GameMgr.cur_level
		level = GameMgr.clamp_level(level)
		UIMgr.open_ui(UI.UIMain,level)
		SaveMgr.set_value(GameMgr.CONFIG_SECTION,"select_level",level)
