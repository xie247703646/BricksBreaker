extends ItemBase
class_name PaddleExpand

func execute()->void:
	if not AchieveMgr.is_finish("Ach003"): AchieveMgr.update_step("Ach003")
	var game = GameMgr.get_game()
	game.paddle.update_size(8)
