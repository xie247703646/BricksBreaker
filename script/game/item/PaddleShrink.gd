extends ItemBase
class_name PaddleShrink

func execute()->void:
	if not AchieveMgr.is_finish("Ach004"): AchieveMgr.update_step("Ach004")
	var game = GameMgr.get_game()
	game.paddle.update_size(-8)
