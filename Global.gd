extends Reference
class_name Global

enum ControlMode{
	Follow,
	Slide,
	Click,
	Key
}

enum Platform{
	TapTap,
	CrazyGame
}
const Cur_Platform:int = Platform.TapTap

const Canvas_Width:int = 720
const Canvas_Height:int = 1280

const Section_Game:String = "Game"
const Section_Co_Create_Level:String = "level_edit"
const Section_Misc:String = "misc"
const Section_Achieve:String = "achieve"
