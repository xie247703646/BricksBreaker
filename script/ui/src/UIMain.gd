extends UIBase
class_name UIMain

onready var level_container: Control = $LevelContainer
onready var lb_level: Label = $LbLevel

var select_level:int = 1
var level_ins:TileMap = null

func on_open(data):
	if data:
		select_level = clamp_level(data)
	show_level()

func on_close(data):
	pass

func show_level()->void:
	if level_ins: level_ins.free()
	level_ins = GameMgr.load_level(select_level)
	level_container.add_child(level_ins)
	lb_level.text = "Level %s" % select_level

func _on_BtnExit_pressed() -> void:
	get_tree().quit()

func _on_BtnStart_pressed() -> void:
	close()
	GameMgr.game_start(select_level)
	UIMgr.open_ui(UI.UIGame)

func _on_BtnRight_pressed() -> void:
	select_level += 1
	select_level = clamp_level(select_level)
	show_level()

func _on_BtnLeft_pressed() -> void:
	select_level -= 1
	select_level = clamp_level(select_level)
	show_level()

func clamp_level(level:int)->int:
	if level > GameMgr.level_cnt:
		level = 1
	elif level <= 0:
		level = GameMgr.level_cnt
	return level
