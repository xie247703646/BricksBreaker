extends ItemBase
class_name ThreeBall

func execute()->void:
	var game = GameMgr.get_game()
	game.create_paddle_ball()
	game.create_paddle_ball()
	game.create_paddle_ball()
