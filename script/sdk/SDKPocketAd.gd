extends Reference
class_name SDKPocketAd

signal reward_video_loaded
signal reward_video_cached
signal reward_video_showed
signal reward_video_exposure
signal reward_video_rewarded
signal reward_video_clicked
signal reward_video_completed
signal reward_video_closed
signal reward_video_succeeded
signal reward_video_failed
signal reward_video_skipped

signal banner_load_success
signal banner_load_fail
signal banner_exposure
signal banner_clicked
signal banner_closed

signal inter_loaded
signal inter_exposure
signal inter_clicked
signal inter_closed
signal inter_success
signal inter_failed

const PocketAd:String = "PocketAd"
const Platform:String = "taptap"

const Pocket_ID:String = "12328"

const BANNER_ID:String = "57566"
const REWARD_VIDEO_ID:String = "56618"
const INTER_ID:String = "57633"

var pocket_ad

func _init() -> void:
	if Engine.has_singleton(PocketAd):
		pocket_ad = Engine.get_singleton(PocketAd)
		pocket_ad.initSDK(Platform,Pocket_ID)
		_init_signal()
		Debug.Log(PocketAd,"初始化成功")
	else:
		Debug.Error(PocketAd,"初始化成功")

func _init_signal()->void:
	pocket_ad.connect("reward_video_loaded",self,"_on_reward_video_loaded")
	pocket_ad.connect("reward_video_cached",self,"_on_reward_video_cached")
	pocket_ad.connect("reward_video_showed",self,"_on_reward_video_showed")
	pocket_ad.connect("reward_video_exposure",self,"_on_reward_video_exposure")
	pocket_ad.connect("reward_video_rewarded",self,"_on_reward_video_rewarded")
	pocket_ad.connect("reward_video_clicked",self,"")
	pocket_ad.connect("reward_video_completed",self,"_on_reward_video_completed")
	pocket_ad.connect("reward_video_closed",self,"_on_reward_video_closed")
	pocket_ad.connect("reward_video_succeeded",self,"_on_reward_video_succeeded")
	pocket_ad.connect("reward_video_failed",self,"_on_reward_video_failed")
	pocket_ad.connect("reward_video_skipped",self,"_on_reward_video_skipped")

	pocket_ad.connect("banner_load_success",self,"_on_banner_load_success")
	pocket_ad.connect("banner_load_fail",self,"_on_banner_load_fail")
	pocket_ad.connect("banner_exposure",self,"_on_banner_exposure")
	pocket_ad.connect("banner_clicked",self,"_on_banner_clicked")
	pocket_ad.connect("banner_closed",self,"_on_banner_closed")
	
	pocket_ad.connect("inter_loaded",self,"_on_inter_loaded")
	pocket_ad.connect("inter_exposure",self,"_on_inter_exposure")
	pocket_ad.connect("inter_clicked",self,"_on_inter_clicked")
	pocket_ad.connect("inter_closed",self,"_on_inter_closed")
	pocket_ad.connect("inter_success",self,"_on_inter_success")
	pocket_ad.connect("inter_failed",self,"_on_inter_failed")

func show_banner()->void:
	if not pocket_ad:
		Debug.Error(PocketAd,"插件实例不存在，无法展示Banner")
		return
	pocket_ad.loadBannerAd(BANNER_ID)

func hide_banner()->void:
	if not pocket_ad:
		Debug.Error(PocketAd,"插件实例不存在，无法隐藏Banner")
		return
	pocket_ad.hideBannerAd()

func show_reward_video()->void:
	if not pocket_ad:
		Debug.Error(PocketAd,"插件实例不存在，无法展示RewardVideo")
		return
	pocket_ad.loadRewardVideoAd(REWARD_VIDEO_ID)

func show_inter()->void:
	if not pocket_ad:
		Debug.Error(PocketAd,"插件实例不存在，无法展示插屏")
		return
	pocket_ad.showInterAD(INTER_ID)

func _on_reward_video_loaded()->void:
	emit_signal("reward_video_loaded")
	EventTracker.track("#reward_video_loaded")
	Debug.Log(PocketAd,"视频加载成功")

func _on_reward_video_cached()->void:
	emit_signal("reward_video_cached")
	EventTracker.track("#reward_video_cached")
	Debug.Log(PocketAd,"视频缓存成功")

func _on_reward_video_showed()->void:
	emit_signal("reward_video_showed")
	EventTracker.track("#reward_video_showed")
	Debug.Log(PocketAd,"视频展示成功")

func _on_reward_video_exposure()->void:
	emit_signal("reward_video_exposure")
	EventTracker.track("#reward_video_exposure")
	Debug.Log(PocketAd,"视频曝光成功")

func _on_reward_video_rewarded()->void:
	emit_signal("reward_video_rewarded")
	EventTracker.track("#reward_video_rewarded")
	Debug.Log(PocketAd,"视频奖励发放")

func _on_reward_video_clicked()->void:
	emit_signal("reward_video_clicked")
	EventTracker.track("#reward_video_clicked")
	Debug.Log(PocketAd,"视频被点击")

func _on_reward_video_completed()->void:
	emit_signal("reward_video_completed")
	EventTracker.track("#reward_video_completed")
	Debug.Log(PocketAd,"视频播放完毕")

func _on_reward_video_closed()->void:
	emit_signal("reward_video_closed")
	EventTracker.track("#reward_video_closed")
	Debug.Log(PocketAd,"视频关闭")

func _on_reward_video_succeeded()->void:
	emit_signal("reward_video_succeeded")
	EventTracker.track("#reward_video_succeeded")
	Debug.Log(PocketAd,"视频加载成功")

func _on_reward_video_failed()->void:
	emit_signal("reward_video_failed")
	EventTracker.track("#reward_video_failed")
	Debug.Log(PocketAd,"视频加载失败")

func _on_reward_video_skipped()->void:
	emit_signal("reward_video_skipped")
	EventTracker.track("#reward_video_skipped")
	Debug.Log(PocketAd,"视频被跳过")

func _on_banner_load_success()->void:
	emit_signal("banner_load_success")
	EventTracker.track("#banner_load_success")
	Debug.Log(PocketAd,"banner加载成功")

func _on_banner_load_fail()->void:
	emit_signal("banner_load_fail")
	EventTracker.track("#banner_load_fail")
	Debug.Log(PocketAd,"banner加载失败")

func _on_banner_exposure()->void:
	emit_signal("banner_exposure")
	EventTracker.track("#banner_exposure")
	if Setting.is_new:
		EventTracker.track("#new_banner_exposure")
	else:
		EventTracker.track("#old_banner_exposure")
	Debug.Log(PocketAd,"banner曝光")

func _on_banner_clicked()->void:
	emit_signal("banner_clicked")
	EventTracker.track("#banner_clicked")
	Debug.Log(PocketAd,"banner被点击")

func _on_banner_closed()->void:
	emit_signal("banner_closed")
	EventTracker.track("#banner_closed")
	Debug.Log(PocketAd,"banner被关闭")

func _on_inter_loaded()->void:
	emit_signal("inter_loaded")
	EventTracker.track("#inter_loaded")
	Debug.Log(PocketAd,"插屏加载完毕")

func _on_inter_exposure()->void:
	emit_signal("inter_exposure")
	EventTracker.track("#inter_exposure")
	if Setting.is_new:
		EventTracker.track("#new_inter_exposure")
	else:
		EventTracker.track("#old_inter_exposure")
	Debug.Log(PocketAd,"插屏曝光")

func _on_inter_clicked()->void:
	emit_signal("inter_clicked")
	EventTracker.track("#inter_clicked")
	Debug.Log(PocketAd,"插屏被点击")

func _on_inter_closed()->void:
	emit_signal("inter_closed")
	EventTracker.track("#inter_closed")
	Debug.Log(PocketAd,"插屏被关闭")

func _on_inter_success()->void:
	emit_signal("inter_success")
	EventTracker.track("#inter_success")
	Debug.Log(PocketAd,"插屏加载成功")

func _on_inter_failed()->void:
	emit_signal("inter_failed")
	EventTracker.track("#inter_failed")
	Debug.Log(PocketAd,"插屏加载失败")
