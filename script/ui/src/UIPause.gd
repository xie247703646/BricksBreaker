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
	
	if GameMgr.is_testing:
		UIMgr.open_ui(UI.UILevelEditor)
	elif GameMgr.is_co_create_level:
		UIMgr.open_ui(UI.UICoCreate)
	else:
		UIMgr.open_ui(UI.UIMain)

func _on_BtnRoast_pressed() -> void:
	OS.shell_open("https://www.taptap.cn/app/270685/review")
