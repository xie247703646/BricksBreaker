extends ItemBase
class_name ThreeBall

func execute()->void:
	if not AchieveMgr.is_finish("Ach002"): AchieveMgr.update_step("Ach002")
	var game = GameMgr.get_game()
	game.create_paddle_ball()
	game.create_paddle_ball()
	game.create_paddle_ball()
