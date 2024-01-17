extends ItemBase
class_name SplitBall

func execute()->void:
	if not AchieveMgr.is_finish("Ach001"): AchieveMgr.update_step("Ach001")
	var game = GameMgr.get_game()
	var ball_container = game.ball_container
	var balls = ball_container.get_children()
	var cur_ball_cnt:int = balls.size()
	if cur_ball_cnt > game.MAX_BALL_CNT: return
	
	for ball in balls:
		var dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		cur_ball_cnt += 3
		if cur_ball_cnt > game.MAX_BALL_CNT: return
