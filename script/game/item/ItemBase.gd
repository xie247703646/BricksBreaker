extends Area2D
class_name ItemBase

const fall_speed:float = 100.0

func _ready() -> void:
	connect("body_entered",self,"_on_body_entered")

func _physics_process(delta: float) -> void:
	global_position.y += delta * fall_speed

func execute()->void:
	pass

func _on_body_entered(body)->void:
	AudioMgr.play_sfx("ding")
	execute()
	queue_free()

