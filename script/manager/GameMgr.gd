extends Node

const LEVEL_PATH = "res://scene/game/level/Level_%s.tscn"
const CONFIG_SECTION = "Game"

var game_scene:PackedScene = preload("res://scene/game/Game.tscn")

var _game_root:Node2D
var _game:Game
var _cur_level:int = 1
var _is_testing:bool = false
var level_cnt = 0
var unlocked_levels:Array = [1]

func init(game_root:Node2D)->void:
	_game_root = game_root
	var level_idx = 1
	while ResourceLoader.exists(LEVEL_PATH % String(level_idx)):
		level_cnt += 1
		level_idx += 1
	if not ConfigMgr.has_section(CONFIG_SECTION):
		ConfigMgr.set_value(CONFIG_SECTION,"select_level",1)
		ConfigMgr.set_value(CONFIG_SECTION,"unlocked_levels",[1])
	else:
		unlocked_levels = ConfigMgr.get_value(CONFIG_SECTION,"unlocked_levels")

func game_start(level:int)->void:
	_is_testing = false
	_cur_level = level
	ConfigMgr.set_value(CONFIG_SECTION,"select_level",level)
	_game = game_scene.instance()
	_game_root.add_child(_game)
	var level_ins = load_level(level)
	_game.init_level(level_ins)

func game_over(win:bool)->void:
	if win: unlock_level(_cur_level + 1)
	get_tree().paused = true
	AudioMgr.clear()
	yield(get_tree().create_timer(2),"timeout")
	_game.queue_free()
	_game = null
	get_tree().paused = false
	UIMgr.close_ui(UI.UIGame)
	if _is_testing:
		UIMgr.open_ui(UI.UILevelEditor)
	else:
		var level = _cur_level + 1 if win else _cur_level
		level = clamp_level(level)
		UIMgr.open_ui(UI.UIMain,level)
		ConfigMgr.set_value(CONFIG_SECTION,"select_level",level)

func game_quit()->void:
	AudioMgr.clear()
	if _game: _game.queue_free()
	_game = null

func game_restart()->void:
	game_quit()
	game_start(_cur_level)

func get_game()->Game:
	return _game

func load_level(level:int)->TileMap:
	var level_path = LEVEL_PATH % String(level)
	if not ResourceLoader.exists(level_path,"PackedScene"):
		level_path = LEVEL_PATH % String(1)
	var level_scene:PackedScene = load(level_path)
	var level_ins = level_scene.instance()
	return level_ins

func test_level(level_ins:TileMap)->void:
	_is_testing = true
	_game = game_scene.instance()
	_game_root.add_child(_game)
	_game.init_level(level_ins)
	UIMgr.open_ui(UI.UIGame,true)

func clamp_level(level:int)->int:
	if level > level_cnt:
		level = 1
	elif level <= 0:
		level = level_cnt
	return level

func unlock_level(level:int)->void:
	if is_level_unlocked(level): return
	unlocked_levels.append(level)
	ConfigMgr.set_value(CONFIG_SECTION,"unlocked_levels",unlocked_levels)

func is_level_unlocked(level:int)->bool:
	return level in unlocked_levels
