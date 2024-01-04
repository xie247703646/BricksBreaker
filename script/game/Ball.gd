extends RigidBody2D
class_name Ball

export var speed:float = 280
export var dir:Vector2 = Vector2.UP

func set_dir(new_dir:Vector2)->void:
	dir = new_dir
	linear_velocity = dir * speed

func _on_Ball_body_entered(body: Node2D) -> void:
	dir = linear_velocity.normalized()
	
	if "Static" in body.get_groups():
		if dir.x < 0.1 and dir.x >= 0:
			dir += Vector2(rand_range(0,0.2),0)
		elif dir.x > -0.1 and dir.x < 0:
			dir += Vector2(rand_range(-0.2,0),0)
		if dir.y < 0.2 and dir.y >= 0:
			dir += Vector2(0,rand_range(0,0.3))
		elif dir.y > -0.2 and dir.y < 0:
			dir += Vector2(0,rand_range(-0.3,0))
		dir = dir.normalized()
		set_dir(dir)
	elif "Paddle" in body.get_groups():
		var paddle:Paddle = body
		var dis = global_position.x - paddle.global_position.x
		var rad = PI / 4
		var half_size = paddle.get_half_size()
		var rate = dis / half_size
		dir = Vector2(rad * rate, -1)
		dir = dir.normalized()
		set_dir(dir)
	elif "Brick" in body.get_groups():
		var global_pos = body.global_position
		body.free()
		SignalMgr.emit_signal("brick_broken",global_pos)
		AudioMgr.play_sfx("dong")
