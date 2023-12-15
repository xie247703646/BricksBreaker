extends Reference
class_name DeviceUtil

static func is_android()->bool:
	return OS.has_feature("android")

static func is_ios()->bool:
	return OS.has_feature("ios")

static func is_mobile()->bool:
	return OS.has_feature("mobile")

static func is_windows()->bool:
	return OS.has_feature("windows")

static func is_macos()->bool:
	return OS.has_feature("macos")

static func is_linux()->bool:
	return OS.has_feature("linux")

static func is_pc()->bool:
	return OS.has_feature("pc")

static func is_web()->bool:
	return OS.has_feature("web")

static func vibrate(duration:float = 500)->void:
	if not Setting.vibrate_enabled: return
	Input.vibrate_handheld(duration)
