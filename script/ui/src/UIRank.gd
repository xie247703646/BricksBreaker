extends UIBase

const Rank_Item:PackedScene = preload("res://scene/item/RankItem.tscn")
const Limit:int = 50

onready var content: VBoxContainer = $VBoxContainer/RankScroller/Content
onready var lb_tip: Label = $LbTip

var level_id:String = "1"

func on_open(data):
	level_id = str(data)
	TapTap.connect("get_rank_data_success",self,"_on_get_rank_data_success")
	TapTap.connect("get_rank_data_fail",self,"_on_get_rank_data_fail")
	TapTap.get_rank_data("Level_%s" % level_id,Limit)
#	TapTap.get_rank_data("pass_time",Limit)
	EventTracker.track("#open_ui_rank")

func on_close(data):
	TapTap.disconnect("get_rank_data_success",self,"_on_get_rank_data_success")
	TapTap.disconnect("get_rank_data_fail",self,"_on_get_rank_data_fail")
	var ui_main = UIMgr.get_ui(UI.UIMain)
	if ui_main: ui_main.call("on_show")

func init_rank(rank_data:Dictionary)->void:
	
	if rank_data.empty(): 
		UIMgr.show_toast(UI.UIToast,"暂无人上榜")
		return
	
	var self_object_id:String = TapTap.get_object_id()
	
	var is_on_rank:bool = false
	
	for i in Limit:
		var rank_idx:String = str(i)
		if not rank_data.has(rank_idx): break
		var rank_item = Rank_Item.instance()
		var object_id:String = rank_data[rank_idx].get("objectid","")
		var is_self:bool = self_object_id == object_id
		if is_self and not is_on_rank: is_on_rank = true
		var item_data:Dictionary = {
			"rank": i + 1,
			"nickname":rank_data[rank_idx].get("nickname","Error"),
			"score":rank_data[rank_idx].get("score",0),
			"is_self": is_self
		}
		content.call_deferred("add_child",rank_item)
		rank_item.call_deferred("set_data",item_data)

	if not is_on_rank: UIMgr.show_toast(UI.UIToast,"暂未上榜")

func _on_BtnClose_pressed() -> void:
	close()

func _on_get_rank_data_success(rank_data:Dictionary)->void:
	lb_tip.queue_free()
	init_rank(rank_data)

func _on_get_rank_data_fail()->void:
	lb_tip.queue_free()
	UIMgr.show_toast(UI.UIToast,"暂无数据，请稍后再试")

func _on_Timer_timeout() -> void:
	lb_tip.text += "。"
	if lb_tip.text.count("。") > 3:
		lb_tip.text = "正在获取数据。"
