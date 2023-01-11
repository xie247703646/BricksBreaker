extends StaticBody2D
class_name Paddle

export var move_speed:float = 550
onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
onready var ball_spawn: Position2D = $BallSpawn
onready var sprite: Sprite = $Sprite

var min_move_offset:float = 0
var max_move_offset:float = 0

const MIN_PADDLE_SIZE = 16
const MAX_PADDLE_SIZE = 128

func _ready() -> void:
	_update_move_offset()

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		global_position.x = clamp(mouse_pos.x,min_move_offset,max_move_offset)
	else:
		var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		global_position.x += move_speed * dir * delta
		global_position.x = clamp(global_position.x,min_move_offset,max_move_offset)

func _update_move_offset()->void:
	var half_size = get_half_size()
	min_move_offset = half_size
	max_move_offset = 720 - half_size

func update_size(value:int)->void:
	var shape:RectangleShape2D = collision_shape_2d.shape
	var size = shape.extents.x + value
	size = clamp(size,MIN_PADDLE_SIZE,MAX_PADDLE_SIZE)
	shape.extents.x = size
	sprite.scale.x = size / 8
	_update_move_offset()

func get_half_size()->float:
	return collision_shape_2d.shape.extents.x
