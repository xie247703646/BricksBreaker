extends Reference
class_name EventTracker

static func track(event_name:String,data:Dictionary = {})->void:
	TapTap.track_event(event_name,data)
