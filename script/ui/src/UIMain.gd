extends UIBase

onready var level_container: Control = $LevelContainer
onready var lb_level: Label = $LbLevel
onready var btn_start: Button = $VBoxContainer/BtnStart
onready var btn_unlock: Button = $VBoxContainer/BtnUnlock
onready var lb_maker: Label = $LbMaker
onready var lb_record: Label = $LbLevel/LbRecord

var select_level:int = 1
var level_ins:TileMap = null

func on_open(data):
	if data:
		select_level = data
	else:
		select_level = int(SaveMgr.get_value(GameMgr.CONFIG_SECTION,"select_level",1))
	show_level()
	if AdMgr.is_valid():
		AdMgr.sdk_ad.connect("reward_video_rewarded",self,"_on_level_unlocked")
		AdMgr.sdk_ad.connect("reward_video_failed",self,"_on_reward_video_failed")


func on_close(data):
	if AdMgr.is_valid():
		AdMgr.sdk_ad.disconnect("reward_video_rewarded",self,"_on_level_unlocked")
		AdMgr.sdk_ad.disconnect("reward_video_failed",self,"_on_reward_video_failed")

func show_level()->void:
	if level_ins: level_ins.free()
	level_ins = GameMgr.load_level(select_level)
	level_container.add_child(level_ins)
	lb_level.text = "关卡-%s" % select_level
	lb_maker.text = "作者:%s" % LevelMaker.get_name(select_level)
	
	var record_dic:Dictionary = SaveMgr.get_value(GameMgr.CONFIG_SECTION,"record",{})
	lb_record.visible = record_dic.has(select_level)
	if lb_record.visible:
		var time:int = record_dic[select_level]
		lb_record.text = "最佳记录 %s" % TimeUtil.format(time)
	if not GameMgr.is_debug: update_level_state()

func update_level_state()->void:
	var is_level_locked = not GameMgr.is_level_unlocked(select_level)
	btn_unlock.visible = GameMgr.is_debug or is_level_locked
	btn_start.visible = not is_level_locked

func _on_BtnStart_pressed() -> void:
	close()
	GameMgr.game_start(select_level)
	UIMgr.open_ui(UI.UIGame)

func _on_BtnRight_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level + 1)
	show_level()

func _on_BtnRight2_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level + 10)
	show_level()

func _on_BtnLeft_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level - 1)
	show_level()

func _on_BtnLeft2_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level - 10)
	show_level()

func _on_BtnEditor_pressed() -> void:
	if GameMgr.unlocked_levels.size() >= 10:
		close()
		UIMgr.open_ui(UI.UICoCreate)
	else:
		UIMgr.show_toast(UI.UIToast,"通过10个关卡后解锁")

func _on_BtnUnlock_pressed() -> void:
	AdMgr.show_reward_video()

func _on_level_unlocked()->void:
	GameMgr.unlock_level(select_level)
	update_level_state()

func _on_reward_video_failed()->void:
	UIMgr.show_toast(UI.UIToast,"暂无合适的广告")
