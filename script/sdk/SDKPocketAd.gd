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

const PocketAd:String = "PocketAd"
const Platform:String = "taptap"

const Pocket_ID:String = "12328"

const BANNER_ID:String = "57566"
const REWARD_VIDEO_ID:String = "56618"

var pocket_ad

func _init() -> void:
	if Engine.has_singleton(PocketAd):
		pocket_ad = Engine.get_singleton(PocketAd)
		pocket_ad.initSDK(Platform,Pocket_ID)
		_init_signal()
		print("PocketAd --> 初始化成功")
	else:
		print("PocketAd --> 初始化失败")


func _init_signal()->void:
	pocket_ad.connect("reward_video_loaded",self,"_on_reward_video_loaded")
	pocket_ad.connect("reward_video_cached",self,"_on_reward_video_cached")
	pocket_ad.connect("reward_video_showed",self,"_on_reward_video_showed")
	pocket_ad.connect("reward_video_exposure",self,"_on_reward_video_exposure")
	pocket_ad.connect("reward_video_rewarded",self,"_on_reward_video_rewarded")
	pocket_ad.connect("reward_video_clicked",self,"_on_reward_video_clicked")
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

func show_banner()->void:
	if not pocket_ad:
		print("PocketAd --> 插件实例不存在，无法展示Banner")
		return
	pocket_ad.loadBannerAd(BANNER_ID)

func hide_banner()->void:
	if not pocket_ad:
		print("PocketAd --> 插件实例不存在，无法隐藏Banner")
		return
	pocket_ad.hideBannerAd()

func show_reward_video()->void:
	if not pocket_ad:
		print("PocketAd --> 插件实例不存在，无法展示RewardVideo")
		return
	pocket_ad.loadRewardVideoAd(REWARD_VIDEO_ID)

func _on_reward_video_loaded()->void:
	emit_signal("reward_video_loaded")
	print("PocketAd --> 视频加载成功")

func _on_reward_video_cached()->void:
	print("PocketAd --> 视频缓存成功")
	emit_signal("reward_video_cached")

func _on_reward_video_showed()->void:
	print("PocketAd --> 视频展示成功")
	emit_signal("reward_video_showed")

func _on_reward_video_exposure()->void:
	print("PocketAd --> 视频曝光成功")
	emit_signal("reward_video_exposure")

func _on_reward_video_rewarded()->void:
	print("PocketAd --> 视频奖励发放")
	emit_signal("reward_video_rewarded")

func _on_reward_video_clicked()->void:
	print("PocketAd --> 视频点击")
	emit_signal("reward_video_clicked")

func _on_reward_video_completed()->void:
	print("PocketAd --> 视频播放完毕")
	emit_signal("reward_video_completed")

func _on_reward_video_closed()->void:
	print("PocketAd --> 视频关闭")
	emit_signal("reward_video_closed")

func _on_reward_video_succeeded()->void:
	print("PocketAd --> 视频加载成功")
	emit_signal("reward_video_succeeded")

func _on_reward_video_failed()->void:
	print("PocketAd --> 视频加载失败")
	emit_signal("reward_video_failed")

func _on_reward_video_skipped()->void:
	print("PocketAd --> 视频跳过")
	emit_signal("reward_video_skipped")

func _on_banner_load_success()->void:
	print("PockedAd --> banner加载成功")
	emit_signal("banner_load_success")

func _on_banner_load_fail()->void:
	print("PockedAd --> banner加载失败")
	emit_signal("banner_load_fail")

func _on_banner_exposure()->void:
	print("PockedAd --> banner曝光")
	emit_signal("banner_exposure")

func _on_banner_clicked()->void:
	print("PockedAd --> banner被点击")
	emit_signal("banner_clicked")

func _on_banner_closed()->void:
	print("PockedAd --> banner被关闭")
	emit_signal("banner_closed")
