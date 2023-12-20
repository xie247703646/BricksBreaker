extends Reference
class_name NormalLevelHandler

func _init(level:int) -> void:
	GameMgr.mode = GameMgr.Mode.Normal
	GameMgr.cur_level = level
	SaveMgr.set_value(Global.Section_Game,"select_level",level)
	GameMgr.game = GameMgr.game_scene.instance()
	GameMgr.game_root.add_child(GameMgr.game)
	GameMgr.level_ins = GameMgr.load_level(level)
	GameMgr.game.init_level(GameMgr.level_ins)

