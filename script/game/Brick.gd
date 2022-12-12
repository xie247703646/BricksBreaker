extends RigidBody2D
class_name Brick

var global_pos

func _ready() -> void:
	global_pos = global_position
	connect("body_entered",self,"_on_Brick_body_entered")

export var move_speed:float = 1000

func _physics_process(delta: float) -> void:
	var dir_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var dir_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	global_position.x += move_speed * dir_x * delta
	global_position.y += move_speed * dir_y * delta

func _on_Brick_body_entered(body: Node) -> void:
	queue_free()
