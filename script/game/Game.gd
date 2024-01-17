extends Node2D
class_name Game

var ball_scene:PackedScene = preload("res://scene/game/Ball.tscn")
var paddle_scene:PackedScene = preload("res://scene/game/Paddle.tscn")
var brick_scenes:Array = [
	preload("res://scene/game//brick/RedBrick.tscn"),
	preload("res://scene/game//brick/OrangeBrick.tscn"),
	preload("res://scene/game//brick/YellowBrick.tscn"),
	preload("res://scene/game//brick/GreenBrick.tscn"),
	preload("res://scene/game//brick/CyanBrick.tscn"),
	preload("res://scene/game//brick/BlueBrick.tscn"),
	preload("res://scene/game//brick/PurpleBrick.tscn"),
	preload("res://scene/game//brick/GrayBrick.tscn"),
	preload("res://scene/game//brick/WhiteBrick.tscn")
]

var item_scenes:Array = [
	preload("res://scene/game/item/SplitBall.tscn"),
	preload("res://scene/game/item/ThreeBall.tscn"),
	preload("res://scene/game/item/PaddleExpand.tscn"),
	preload("res://scene/game/item/PaddleShrink.tscn")
]

var item_weight_arr:Array = [
	35,35,20,10
]

const MAX_BALL_CNT = 500

onready var brick_container: Node2D = $BrickContainer
onready var ball_container: Node2D = $BallContainer
onready var static_container: Node2D = $StaticContainer
onready var item_container: Node2D = $ItemContainer
var paddle: Paddle

func _ready() -> void:
	UIMgr.open_ui(UI.UIGame)

	item_weight_arr = CloudDataMgr.get_value("item_weight_arr",item_weight_arr)
	
	SignalMgr.connect("brick_broken",self,"_on_brick_broken")
	paddle = create_paddle()
	yield(get_tree().create_timer(1),"timeout")
	create_paddle_ball()

func init_level(level_map:TileMap)->void:
	var cell_map_pos_arr:Array = level_map.get_used_cells()
	for cell_map_pos in cell_map_pos_arr:
		var type = level_map.get_cell(cell_map_pos.x,cell_map_pos.y)
		var brick_global_pos = level_map.map_to_world(cell_map_pos) + Vector2.ONE * 8
		create_brick(brick_global_pos,type)
	level_map.queue_free()

func create_paddle():
	var paddle_ins = paddle_scene.instance()
	add_child(paddle_ins)
	paddle_ins.global_position = Vector2(360,1000)
	return paddle_ins

func create_brick(global_pos:Vector2,type:int)->void:
	var brick_ins = brick_scenes[type].instance()
	if "Static" in brick_ins.get_groups():
		static_container.add_child(brick_ins)
	else:
		brick_container.add_child(brick_ins)
	brick_ins.global_position = global_pos

func create_ball(global_pos:Vector2,dir:Vector2)->void:
	var ball_ins:Ball = ball_scene.instance()
	ball_container.call_deferred("add_child",ball_ins)
	ball_ins.set_deferred("global_position",global_pos)
	ball_ins.call_deferred("set_dir",dir)
	
	var ball_cnt:int = ball_container.get_child_count()
	
	if ball_cnt >= 100 and not AchieveMgr.is_finish("Ach005"):
		AchieveMgr.reach("Ach005")
		
	if ball_cnt >= 200 and not AchieveMgr.is_finish("Ach006"):
		AchieveMgr.reach("Ach006")
		
	if ball_cnt >= 300 and not AchieveMgr.is_finish("Ach007"):
		AchieveMgr.reach("Ach007")
		
	if ball_cnt >= 400 and not AchieveMgr.is_finish("Ach008"):
		AchieveMgr.reach("Ach008")
	
	if ball_cnt >= 490 and not AchieveMgr.is_finish("Ach009"):
		AchieveMgr.reach("Ach009")
	

func create_paddle_ball()->void:
	var rad = PI / 3
	var dir = Vector2(rand_range(-cos(rad),cos(rad)),-1)
	create_ball(paddle.ball_spawn.global_position,dir)

func create_item(item_type:int,global_pos:Vector2)->void:
	var item_scene:PackedScene = item_scenes[item_type]
	var item_ins:ItemBase = item_scene.instance()
	item_ins.global_position = global_pos
	item_container.call_deferred("add_child",item_ins)

func _on_brick_broken(global_pos:Vector2)->void:
	if brick_container.get_child_count() <= 0:
		GameMgr.call_deferred("game_over",true)
		return
	DeviceUtil.vibrate(50)
	var ball_cnt = ball_container.get_child_count()
	var p = 0.1 * (MAX_BALL_CNT - ball_cnt * 10 + 10) / MAX_BALL_CNT
	p = clamp(p,0.01,0.1)
	if randf() < p:
		var idx = MathUtil.rand_weight(item_weight_arr)
		create_item(idx,global_pos)

func _on_DeadArea_body_entered(body: Node2D) -> void:
	body.free()
	if ball_container.get_child_count() <= 0:
		GameMgr.call_deferred("game_over",false)

func _on_DeadArea_area_entered(area: Area2D) -> void:
	area.queue_free()
