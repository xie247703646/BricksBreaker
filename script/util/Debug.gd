extends Reference
class_name Debug

static func Log(tag:String,msg:String)->void:
	print("Debug N: %s --> %s" % [tag,msg])

static func Error(tag:String,msg:String)->void:
	print("Debug E: %s --> %s" % [tag,msg])

static func Warn(tag:String,msg:String)->void:
	print("Debug W: %s --> %s" % [tag,msg])
