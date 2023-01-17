extends UIBase
class_name UIMain

onready var level_container: Control = $LevelContainer
onready var lb_level: Label = $LbLevel
onready var btn_start: Button = $VBoxContainer/BtnStart
onready var btn_unlock: Button = $VBoxContainer/BtnUnlock

var select_level:int = 1
var level_ins:TileMap = null
var ad_loaded:bool = false

func on_open(data):
	if data:
		select_level = data
	else:
		select_level = int(ConfigMgr.get_value(GameMgr.CONFIG_SECTION,"select_level",1))
	show_level()
	PocketAd.preloadRewardVideoAD(PocketAd.RewardVideoId)
	PocketAd.connect("onRewardVideoADrResult",self,"_on_level_unlocked")

func on_close(data):
	PocketAd.disconnect("onRewardVideoADrResult",self,"_on_level_unlocked")

func show_level()->void:
	if level_ins: level_ins.free()
	level_ins = GameMgr.load_level(select_level)
	level_container.add_child(level_ins)
	lb_level.text = "Level %s" % select_level
	update_level_state()

func update_level_state()->void:
	var is_level_locked = not GameMgr.is_level_unlocked(select_level)
	btn_unlock.visible = is_level_locked
	btn_start.visible = not is_level_locked

func _on_BtnExit_pressed() -> void:
	get_tree().quit()

func _on_BtnStart_pressed() -> void:
	close()
	GameMgr.game_start(select_level)
	UIMgr.open_ui(UI.UIGame)

func _on_BtnRight_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level + 1)
	show_level()

func _on_BtnLeft_pressed() -> void:
	select_level = GameMgr.clamp_level(select_level - 1)
	show_level()

func _on_BtnEditor_pressed() -> void:
	close()
	UIMgr.open_ui(UI.UILevelEditor)

func _on_BtnUnlock_pressed() -> void:
	if not ad_loaded:
		print("广告暂未加载")
		return
	PocketAd.showRewardVideoAD()

func _on_level_unlocked(type)->void:
	print("type:"+type)
	match type:
		"onADLoaded":
			ad_loaded = true
			print("预加载成功!")
		"onReward":
			GameMgr.unlock_level(select_level)
			update_level_state()

