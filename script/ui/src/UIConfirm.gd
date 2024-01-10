extends UIBase

onready var lb_title: Label = $LbTitle
onready var lb_tip: Label = $LbTip
onready var btn_no: Button = $BtnNo
onready var btn_yes: Button = $BtnYes

var func_no:FuncRef
var func_yes:FuncRef

func on_open(data = null)->void:
	if data.has("title"): lb_title.text = data["title"]
	if data.has("tip"): lb_tip.text = data["tip"]
	if data.has("text_no"): btn_no.text = data["text_no"]
	if data.has("text_yes"): btn_yes.text = data["text_yes"]
	if data.has("func_no"): func_no = data["func_no"]
	if data.has("func_yes"): func_yes = data["func_yes"]
	if data.has("hide_yes"): btn_yes.visible = false
	if data.has("hide_no"): btn_no.visible = false

func on_close(data = null)->void:
	func_no = null
	func_yes = null

func _on_BtnNo_pressed() -> void:
	if func_no: func_no.call_func()
	close()

func _on_BtnYes_pressed() -> void:
	if func_yes: func_yes.call_func()
	close()
