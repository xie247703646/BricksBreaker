extends Node

var ins

func _ready() -> void:
	if not is_valid(): return
	var window = JavaScript.get_interface("window")
	ins = window.CrazyGames.SDK
	Debug.Log(name,"init success")

func is_valid()->bool:
	return OS.has_feature("crazygames")
