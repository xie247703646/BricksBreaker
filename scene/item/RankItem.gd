extends HBoxContainer

onready var lb_rank: Label = $LbRank
onready var lb_name: Label = $LbName
onready var lb_score: Label = $LbScore

func set_data(data:Dictionary)->void:
	$LbRank.text = str(data.get("rank",1))
	$LbName.text = data.get("nickname","Error")
	$LbScore.text = TimeUtil.format(data.get("score",0))
	modulate = Color.red if data.get("is_self",false) else Color.white
