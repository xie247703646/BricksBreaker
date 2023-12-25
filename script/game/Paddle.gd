extends StaticBody2D
class_name Paddle

const MIN_PADDLE_SIZE = 16
const MAX_PADDLE_SIZE = 128

export var move_speed:float = 550
onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
onready var ball_spawn: Position2D = $BallSpawn
onready var sprite: Sprite = $Sprite

var min_move_offset:float = 0
var max_move_offset:float = 0
var cur_move_speed:float = 0.0
var pre_mouse_pos_x:float = INF

func _ready() -> void:
	_update_move_offset()

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.y < 640: return
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		match Setting.control_mode:
			Global.ControlMode.Follow: _update_follow_move(mouse_pos)
			Global.ControlMode.Slide: _update_slide_move(mouse_pos,delta)
			Global.ControlMode.Click: _update_click_move(mouse_pos,delta)
	else:
		cur_move_speed = 0.0
		pre_mouse_pos_x = INF

func _update_follow_move(mouse_pos:Vector2)->void:
	var global_pos_x:float = lerp(global_position.x,mouse_pos.x,0.5)
	global_position.x = clamp(global_pos_x,min_move_offset,max_move_offset)

func _update_slide_move(mouse_pos:Vector2,delta:float)->void:
	if pre_mouse_pos_x == INF: pre_mouse_pos_x = mouse_pos.x
	var offset:float = mouse_pos.x - pre_mouse_pos_x
	var speed:float = offset * 80
	global_position.x += speed * delta
	global_position.x = clamp(global_position.x,min_move_offset,max_move_offset)
	pre_mouse_pos_x = mouse_pos.x

func _update_click_move(mouse_pos:Vector2,delta:float)->void:
	var dir:int = 1 if mouse_pos.x > 360 else -1
	cur_move_speed = lerp(cur_move_speed,move_speed,0.25)
	global_position.x += cur_move_speed * dir * delta
	global_position.x = clamp(global_position.x,min_move_offset,max_move_offset)

func _update_move_offset()->void:
	var half_size = get_half_size()
	min_move_offset = half_size
	max_move_offset = Global.Canvas_Width - half_size

func update_size(value:int)->void:
	var shape:RectangleShape2D = collision_shape_2d.shape
	var size = shape.extents.x + value
	size = clamp(size,MIN_PADDLE_SIZE,MAX_PADDLE_SIZE)
	shape.extents.x = size
	sprite.scale.x = size / 8
	_update_move_offset()

func get_half_size()->float:
	return collision_shape_2d.shape.extents.x
