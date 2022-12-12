extends Node

const LEVEL_PATH = "res://scene/game/level/Level_%s.tscn"
const CONFIG_SECTION = "Game"

var game_scene:PackedScene = preload("res://scene/game/Game.tscn")

var _game_root:Node2D
var _game:Game
var _cur_level:int = 1

var level_cnt = 0

func init(game_root:Node2D)->void:
	_game_root = game_root
	var level_idx = 1
	while ResourceLoader.exists(LEVEL_PATH % String(level_idx)):
		level_cnt += 1
		level_idx += 1

func game_start(level:int)->void:
	_cur_level = level
	_game = game_scene.instance()
	_game_root.add_child(_game)
	var level_ins = load_level(level)
	_game.init_level(level_ins)

func game_over(win:bool)->void:
	get_tree().paused = true
	AudioMgr.clear()
	yield(get_tree().create_timer(2),"timeout")
	_game.free()
	_game = null
	get_tree().paused = false
	UIMgr.close_ui(UI.UIGame)
	if win:
		UIMgr.open_ui(UI.UIMain,_cur_level + 1)
	else:
		UIMgr.open_ui(UI.UIMain,_cur_level)

func game_quit()->void:
	AudioMgr.clear()
	if _game: _game.free()
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

func save()->void:
	ConfigMgr.set_value(CONFIG_SECTION,"level",String(_cur_level))
