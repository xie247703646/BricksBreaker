extends ItemBase
class_name PaddleExpand

func _execute()->void:
	var game = GameMgr.get_game()
	game.paddle.update_size(8)
