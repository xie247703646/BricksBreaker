extends Reference
class_name TimeUtil

static func format(ms: int) -> String:  
	var h:int = 0
	var m:int = 0
	var s:int = 0
  
	h = ms / 3600000
	m = (ms % 3600000) / 60000
	s = (ms % 60000) / 1000
	
	var res:String = ""
	
	if h > 0: res += "%s小时" % h
	
	if m > 0: res += "%s分钟" % m
	
	if res != "" and s == 0: return res
	
	res += "%s秒" % s
	
	return res
