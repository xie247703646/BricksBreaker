extends Node

var achieve_dic:Dictionary = {}

func init()->void:
	achieve_dic = SaveMgr.get_value(Global.Section_Achieve,"achieve",{})

func reach(achieve_id:String)->void:
	if not achieve_dic.has(achieve_id): achieve_dic[achieve_id] = { "finish":false, "step":0 }
	var achieve:Dictionary = achieve_dic[achieve_id]
	achieve["finish"] = true
	save_data()
	TapTap.reach_achieve(achieve_id)
	Debug.Log(name,"达成成就:" + achieve_id)

func update_step(achieve_id:String,step:int = 1,save:bool = true)->void:
	if not achieve_dic.has(achieve_id): achieve_dic[achieve_id] = { "finish":false, "step":0 }
	var achieve:Dictionary = achieve_dic[achieve_id]
	achieve["step"] += step
	if achieve["step"] >= CfgAchieve.Data[achieve_id]["target_step"]:
		reach(achieve_id)
	else:
		if save: save_data()

func is_finish(achieve_id:String)->bool:
	if not achieve_dic.has(achieve_id): return false
	var achieve:Dictionary = achieve_dic[achieve_id]
	return achieve["finish"]

func save_data()->void:
	SaveMgr.set_value(Global.Section_Achieve,"achieve",achieve_dic)
