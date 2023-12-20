extends Node

const LEVEL_PATH = "res://scene/game/level/Level_%s.tscn"
const CONFIG_SECTION = "Game"

enum Mode{
	Normal,
	Test,
	CoCreate
}

var game_scene:PackedScene = preload("res://scene/game/Game.tscn")

var game_root:Node2D
var game:Game
var level_ins:TileMap

var cur_level:int = 1
var level_cnt = 0
var unlocked_levels:Array = [1]
var is_debug:bool = true
var start_time:int = 0

var mode:int = Mode.Normal

func init(game_root:Node2D)->void:
	self.game_root = game_root
	var level_idx = 1
	while ResourceLoader.exists(LEVEL_PATH % String(level_idx)):
		level_cnt += 1
		level_idx += 1
	if not SaveMgr.has_section(CONFIG_SECTION):
		SaveMgr.set_value(CONFIG_SECTION,"select_level",1)
		SaveMgr.set_value(CONFIG_SECTION,"unlocked_levels",[1])
	else:
		unlocked_levels = SaveMgr.get_value(CONFIG_SECTION,"unlocked_levels")

func start_normal_level(level:int)->void:
	mode = Mode.Normal
	cur_level = level
	SaveMgr.set_value(CONFIG_SECTION,"select_level",level)
	game = game_scene.instance()
	game_root.add_child(game)
	level_ins = load_level(level)
	game.init_level(level_ins)
	start_time = Time.get_ticks_msec()

func start_test_level(level_ins:TileMap)->void:
	mode = Mode.Test
	game = game_scene.instance()
	game_root.add_child(game)
	game.init_level(level_ins)
	start_time = Time.get_ticks_msec()

func start_cocreate_level(level_ins:TileMap)->void:
	mode = Mode.CoCreate
	game = game_scene.instance()
	game_root.add_child(game)
	game.init_level(level_ins)
	start_time = Time.get_ticks_msec()

func game_over(win:bool)->void:
	if win: unlock_level(cur_level + 1)
	UIMgr.show_input_block()
	get_tree().paused = true
	AudioMgr.clear()
	yield(get_tree().create_timer(1),"timeout")
	UIMgr.hide_input_block()
	get_tree().paused = false
	get_tree().call_group("Ball","queue_free")
	get_tree().call_group("Item","queue_free")
	UIMgr.open_ui(UI.UIFinish,win)

func game_quit()->void:
	AudioMgr.clear()
	if game: game.queue_free()
	game = null

func get_game()->Game:
	return game

func load_level(level:int)->TileMap:
	var level_path = LEVEL_PATH % String(level)
	if not ResourceLoader.exists(level_path,"PackedScene"):
		level_path = LEVEL_PATH % String(1)
	var level_scene:PackedScene = load(level_path)
	level_ins = level_scene.instance()
	return level_ins
func clamp_level(level:int)->int:
	if level > level_cnt:
		level = 1
	elif level <= 0:
		level = level_cnt
	return level

func unlock_level(level:int)->void:
	if is_level_unlocked(level): return
	unlocked_levels.append(level)
	SaveMgr.set_value(CONFIG_SECTION,"unlocked_levels",unlocked_levels)

func is_level_unlocked(level:int)->bool:
	return level in unlocked_levels

func open_game_page()->void:
	OS.shell_open("https://www.taptap.cn/app/270685/review")
