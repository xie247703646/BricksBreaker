extends Node

const Android:String = "Android"

var sdk_ad:Reference = null

var is_just_show_inter:bool = false

func init()->void:
	match OS.get_name():
		Android: sdk_ad = SDKPocketAd.new()

func show_banner()->void:
	if is_valid():
		sdk_ad.call("show_banner")
	else:
		Debug.Warn(name,"banner展示失败")

func hide_banner()->void:
	if is_valid():
		sdk_ad.call("hide_banner")
	else:
		Debug.Warn(name,"banner隐藏失败")

func show_reward_video()->void:
	if is_valid():
		sdk_ad.call("show_reward_video")
	else:
		UIMgr.show_toast(UI.UIToast,tr("key_no_ad"))
		Debug.Warn(name,"reward_video展示失败")

func show_inter()->void:
	if is_valid():
		sdk_ad.call("show_inter")
	else:
		Debug.Warn(name,"插屏展示失败")

func is_valid()->bool:
	return sdk_ad != null
