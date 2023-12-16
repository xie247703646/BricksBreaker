class_name MathUtil

static func rand_weight(weight_arr:Array)->int:
	if not weight_arr:return -1
	if weight_arr.size() <= 0: return 0
	var arr = [0]
	var total_weight:int = 0
	for i in range(weight_arr.size()):
		var weight:int = weight_arr[i]
		total_weight += weight
		arr.append(arr[i] + weight)
	var rand = rand_range(0,total_weight)
	for i in range(arr.size()):
		if rand >= arr[i] and rand <= arr[i + 1]: return i
	return -1

static func encode(input_str:String)->String:  
	var encode_str:String = ""
	
	var pivot:String = input_str[0]
	var count:int = 0
	
	for i in len(input_str):
		var s = input_str[i]
		if s == pivot:
			count += 1
		else:
			encode_str += str(count) + pivot
			pivot = s
			count = 1
	
	encode_str += str(count) + pivot

	return encode_str  
  
static func decode(encode_str:String)->String:
	if not encode_str: return ""
	
	var total_len:int = len(encode_str)
	var count_str:String
	var final_str:String
	var i = 0
	
	while(i < total_len):
		var s:String = encode_str[i]
		i += 1
		var asc = ord(s)
		if asc == 32: 
			print("space")
		elif asc >= 65 and asc <= 90:
			if count_str.is_valid_integer():
				var count:int = count_str.to_int()
				for j in count: final_str += s
			count_str = ""
		else:
			count_str += s
	return final_str
