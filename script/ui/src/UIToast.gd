extends Control

onready var lb_tip: Label = $LbTip

func on_show(msg:String):
	lb_tip.text = msg

func on_hide():
	queue_free()
