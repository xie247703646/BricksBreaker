extends Node

const Android:String = "Android"

var sdk_ad:Reference = null

func init()->void:
	match OS.get_name():
		Android: sdk_ad = SDKPocketAd.new()

func show_banner()->void:
	if is_valid():
		sdk_ad.call("show_banner")
	else:
		print("AdMgr --> banner展示失败")

func hide_banner()->void:
	if is_valid():
		sdk_ad.call("hide_banner")
	else:
		print("AdMgr --> banner隐藏失败")

func show_reward_video()->void:
	if is_valid():
		sdk_ad.call("show_reward_video")
	else:
		UIMgr.show_toast(UI.UIToast,"暂无合适广告")
		print("AdMgr --> reward_video展示失败")

func is_valid()->bool:
	return sdk_ad != null
