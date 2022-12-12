extends ItemBase
class_name SplitBall

func _execute()->void:
	var game = GameMgr.get_game()
	var ball_container = game.ball_container
	var balls = ball_container.get_children()
	if balls.size() > game.MAX_BALL_CNT: return
	for ball in balls:
		var dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		dir = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		game.create_ball(ball.global_position,dir)
		if ball_container.get_children().size() > game.MAX_BALL_CNT: return
